class HipchatController < ApplicationController
  def index
    personal = 'vBso0mRNZDCRNFcvriCDy1mZ6ssdMNeV6NoNK8U9'
    client = HipChat::Client.new(personal, :api_version => 'v2')
    client["WynHooked"].send("@TheGinsberg", " is hooked bad and in need of immediate assistance!.", :notify => true)
  end
end
