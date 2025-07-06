class MouseLauncher < Formula
  desc "A simple mouse movement utility for macOS using arrow keys"
  homepage "https://github.com/shmulisarmy/mouse-launcher"
  version "1.0.0"
  
  if OS.mac?
    url "https://github.com/shmulisarmy/mouse-launcher/releases/download/v1.0.0/mouse_launcher_darwin_amd64"
    sha256 "PLACEHOLDER_SHA256" # This will need to be updated after release
  end

  def install
    if OS.mac?
      bin.install "mouse_launcher_darwin_amd64" => "mouse_launcher"
    end
  end

  test do
    system "#{bin}/mouse_launcher", "--help"
  end
end 