class MouseLauncher < Formula
  desc "A simple mouse movement utility for macOS using arrow keys"
  homepage "https://github.com/shmulisarmy/mouse-launcher"
  version "1.0.1"
  
  if OS.mac?
    url "https://github.com/shmulisarmy/mouse-launcher/releases/download/v1.0.1/mouse_launcher_darwin_arm64"
    sha256 "c77864cb1fec686e7e3a9aa60aebd1d123c8a7f03207e2a93f9cc018ded0ff14"
  end

  def install
    if OS.mac?
      bin.install "mouse_launcher_darwin_arm64" => "mouse_launcher"
    end
  end

  test do
    system "#{bin}/mouse_launcher", "--version"
  end
end 