unless File.exists?("/Applications/RightZoom.app")

  remote_file "#{Chef::Config[:file_cache_path]}/RightZoom.zip" do
    source "http://www.macupdate.com/download/30591/RightZoom.zip"
    owner WS_USER
    checksum "3fb25506dd2f324f6800a84a6d6f60236eb6f410f8f9e40df1920faa08d02551"
  end

  execute "unzip RightZoom" do
    command "unzip #{Chef::Config[:file_cache_path]}/RightZoom.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy RightZoom to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/RightZoom.app #{Regexp.escape("/Applications/RightZoom.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if RightZoom.app was installed" do
    block do
      raise "RightZoom.app was not installed" unless File.exists?("/Applications/RightZoom.app")
    end
  end

end



