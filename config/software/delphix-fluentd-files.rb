name "delphix-fluentd-files"
#version '' # git ref

dependency "td-agent"

# This software sets up delphix-fluentd related files.
# It customizes the default td-agent package for delphix-fluentd, see comments below.
# Separating file into td-agent.rb and delphix-fluentd-files.rb is for speed up package building

build do
  block do
    # setup related files
    pkg_type = project.packagers_for_system.first.id.to_s
    root_path = "/" # for ERB
    install_path = project.install_dir # for ERB
    project_name = project.name # for ERB
    is_td_agent2 = project.build_version.start_with?('2.')
    project_name_snake = project.name.gsub('-', '_') # for variable names in ERB
    rb_major, rb_minor, rb_teeny = project.overrides[:ruby][:version].split("-", 2).first.split(".", 3)
    gem_dir_version = "#{rb_major}.#{rb_minor}.0" # gem path's teeny version is always 0
    install_message = nil

    template = ->(*parts) { File.join('templates', *parts) }
    generate_from_template = ->(dst, src, erb_binding, opts={}) {
      mode = opts.fetch(:mode, 0755)
      destination = dst.gsub('td-agent', project.name)
      FileUtils.mkdir_p File.dirname(destination)
      File.open(destination, 'w', mode) do |f|
        f.write ERB.new(File.read(src), nil, '<>').result(erb_binding)
      end
    }

    if File.exist?(template.call('INSTALL_MESSAGE'))
      install_message = File.read(template.call('INSTALL_MESSAGE'))
    end

    # copy pre/post scripts into omnibus path (./package-scripts/td-agentN)
    FileUtils.mkdir_p(project.package_scripts_path)
    Dir.glob(File.join(project.package_scripts_path, '*')).each { |f|
      FileUtils.rm_f(f) if File.file?(f)
    }
    # templates/package-scripts/td-agent/xxxx/* -> ./package-scripts/td-agentN
    Dir.glob(template.call('package-scripts', 'td-agent', pkg_type, '*')).each { |f|
      package_script = File.join(project.package_scripts_path, File.basename(f))
      generate_from_template.call package_script, f, binding, mode: 0755
    }

    #
    # Delphix customizations (compare to td-agent-files.rb):
    #  - Skip setup plist - since we only build for debian
    #  - Skip setup init.d file - since we use systemd
    #  - Skip systemd unit file - since its delivered via app gate
    #  - Skip conf file (/etc/td-agent) - since its created dynamically by app stack (/etc/fluent/fluent.conf)
    #  - Skip ./resources/etc -> INSTALL_PATH/etc
    #  - Only need td-agent and td-agent-gem scripts to be delivered as part of the package.
    #

    ["td-agent", "td-agent-gem"].each { |command|
      sbin_path = File.join(install_path, 'usr', 'sbin', command)
      # templates/usr/sbin/yyyy.erb -> INSTALL_PATH/usr/sbin/yyyy
      generate_from_template.call sbin_path, template.call('usr', 'sbin', "#{command}.erb"), binding, mode: 0755
    }

  end
end
