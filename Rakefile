require 'rake'
require 'erb'

IGNORE = %w[
  Rakefile
  base.png
  README.md
].freeze
desc "install the dot files into user's home directory"
task :test do
  install_fonts
end

task :install do
  replace_all = false
  files = Dir['*'] - %w[Rakefile README.rdoc LICENSE oh-my-zsh]
  files.each do |file|
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    if File.exist?(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"))
      if File.identical? file, File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}")
        puts "identical ~/.#{file.sub(/\.erb$/, '')}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{file.sub(/\.erb$/, '')}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{file.sub(/\.erb$/, '')}"
        end
      end
    else
      link_file(file)
    end
  end
  install_oh_my_zsh
  switch_to_zsh
  install_fonts
  install_doom
  gsettings_swapescape
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub(/\.erb$/, '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub(/\.erb$/, '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub(/\.erb$/, '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end

def switch_to_zsh
  if ENV["SHELL"] =~ /zsh/
    puts "using zsh"
  else
    print "switch to zsh? (recommended) [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "switching to zsh"
      system %Q{sudo apt install zsh}
      system %Q{chsh -s $(which zsh)}
    when 'q'
      exit
    else
      puts "skipping zsh"
    end
  end
end


def install_doom
  url_doom = "https://github.com/hlissner/doom-emacs"

  if(Dir.exist?('~/.emacs.d'))
    puts 'emacs.d already exists'
  else
    puts 'downloading doom emacs'
    system %Q{git clone --depth 1 #{url_doom} ~/.emacs.d}
    system %Q{~/.emacs.d/bin/doom install}
  end

end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], ".oh-my-zsh"))
    puts "found ~/.oh-my-zsh"
  else
    print "install oh-my-zsh? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing oh-my-zsh"
      system %Q{git clone https://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh"}
      system %Q{git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k}
    when 'q'
      exit
    else
      puts "skipping oh-my-zsh, you will need to change ~/.zshrc"
    end
  end
end

def install_fonts
  fonts = ['JetBrainsMono']
  print "install fonts? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "installing nerd fonts"
      system %Q{mkdir fonts}
      fonts.each
      fonts.each { |item|
          puts item
          system %Q{wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/#{item}.zip}
          system %Q{mv #{item}.zip fonts/}
          system %Q{cd fonts && unzip #{item}.zip}
      }
      system %Q{fc-cache -fv}
    when 'q'
      puts "skipping fonts"
      exit
    end
end

def gsettings_swapescape
  print "apply gsettings conf to swap capslock and escape? [ynq] "
    case $stdin.gets.chomp
    when 'y'
      puts "applying xkb-options through gsettings"
      system %Q{gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"}
    when 'q'
      puts "skipping"
      exit
    end
end
