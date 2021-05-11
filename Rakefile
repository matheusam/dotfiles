require 'rake'

desc 'Installing Dotfiles'
task :install do
  puts "Forked from Campus Code Dotfiles"

  install_files(Dir.glob([
    "aliases",
    "tmux.conf",
    "vimrc",
    "zsh",
    "zshenv",
    "zshrc",
    "bin",
    "vim",
    "git/*",
    "irb/*"
  ]))

  install_prereqs
  install_fonts
  install_vim_plugins
  install_zsh_syntax_highlighting
  install_tmux_battery_plugin
  tmux_copy_mode
  change_shell
  installation_message
end

private

def run_command(cmd)
  puts "running #{cmd}"
  system cmd
rescue
  puts "Error running #{cmd}"
end

def install_files(files)
  files.each do |f|
    file_name = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    file = "#{ENV["HOME"]}/.#{file_name}"

    if File.exists?(file)
      puts "Moving #{file} to #{file}.bkp"
      run_command %{ mv #{file} #{file}.bkp }
    end

    run_command %{ ln -nfs "#{source}" "#{file}" }
  end
end

def install_prereqs
  run_command %{ $HOME/.dotfiles/pre_reqs/mac.sh } if macos?
  run_command %{ $HOME/.dotfiles/pre_reqs/debian.sh } if debian?
  run_command %{ $HOME/.dotfiles/pre_reqs/ubuntu.sh } if ubuntu?
end

def install_fonts
  puts "======================================================"
  puts "Installing patched fonts for Powerline/Lightline."
  puts "======================================================"
  run_command %{ mkdir -p ~/.fonts && cp ~/.dotfiles/fonts/* ~/.fonts && fc-cache -vf ~/.fonts } if linux?
  puts
end

def install_vim_plugins
  system "vim -N \"+set hidden\" \"+syntax on\" +PlugInstall +qall"
end

def install_zsh_syntax_highlighting
  unless File.exists?("#{ENV["HOME"]}/.zsh-syntax-highlighting")
    run_command %{ git clone --depth=1 git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting }
  end
end

def install_tmux_battery_plugin
  folder = '.tmux-battery'
  unless File.exists?("#{ENV["HOME"]}/#{folder}")
    run_command %{ git clone --depth=1 https://github.com/tmux-plugins/tmux-battery ~/#{folder} }
    run_command %{ echo "run-shell ~/#{folder}/battery.tmux" >> ~/.tmux.conf.local }
  end
end

def tmux_copy_mode
  folder = "$HOME/.dotfiles"
  run_command %{ cp #{folder}/templates/copy_mode_mac.conf.tmp $HOME/.tmux_copy_mode.conf } if macos?
  run_command %{ cp #{folder}/templates/copy_mode_linux.conf.tmp $HOME/.tmux_copy_mode.conf } if linux?
end

def change_shell
  puts "You will change your default shell to zsh"
  run_command %{ chsh -s $(which zsh) }
end

def installation_message
  puts ''
  puts ''
  puts '======================================================================='
  puts 'Thank you!'
  puts ''
  puts ''
  puts "- Change your terminal window to Run command as login shell and RESTART"
  puts '======================================================================='
end

def linux
  RUBY_PLATFORM.downcase.include?("linux")
end

def macos?
  RUBY_PLATFORM.downcase.include?("darwin")
end

def ubuntu?
  return false unless linux?

  `cat /etc/issue.net | awk '{print $1}'`.chomp == 'Ubuntu'
end

def debian?
  return false unless linux?

  `cat /etc/issue.net | awk '{print $1}'`.chomp == 'Debian'
end
