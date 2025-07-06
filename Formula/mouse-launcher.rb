class MouseLauncher < Formula
  desc "A simple mouse movement utility for macOS using arrow keys"
  homepage "https://github.com/shmulisarmy/mouse-launcher"
  version "1.0.1"
  
  if OS.mac?
    url "https://github.com/shmulisarmy/mouse-launcher/releases/download/v1.0.1/mouse_launcher_darwin_universal"
    sha256 "PLACEHOLDER_SHA256" # Will be updated after release is created
  end

  def install
    if OS.mac?
      bin.install "mouse_launcher_darwin_universal" => "mouse_launcher"
    end
  end

  test do
    system "#{bin}/mouse_launcher", "--version"
  end
end 