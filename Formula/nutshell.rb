class Nutshell < Formula
  desc "Local personal trace ingestion runtime"
  homepage "https://github.com/androidStern/nutshell"
  version "0.1.26"
  license "MIT"

  depends_on macos: :sonoma

  on_arm do
    url "https://github.com/androidStern/nutshell/releases/download/v0.1.26/nutshell-0.1.26-darwin-arm64.tar.gz"
    sha256 "62806e5e3191d7f730f78cd2d15120c17098f7ba9aa82d2c80481a46dd849177"
  end

  on_intel do
    url "https://github.com/androidStern/nutshell/releases/download/v0.1.26/nutshell-0.1.26-darwin-x64.tar.gz"
    sha256 "220ba25633953244599a8abd47faf4fa2cabc9f6b9182a70a31c80e39ad53c2d"
  end

  def install
    bin.install "bin/nutshell"
    prefix.install "Nutshell.app" if File.directory?("Nutshell.app")
  end

  def caveats
    <<~EOS
      Run `nutshell setup` after install. Protected-data sync is owned by Nutshell.app, not a Homebrew service.
    EOS
  end

  test do
    ENV["NUTSHELL_CONFIG"] = testpath/"nutconfig.jsonc"
    ENV["NUTSHELL_ROOT"] = testpath/"Nutshell"
    system bin/"nutshell", "--version"
    assert_match "nutshell setup", shell_output("#{bin}/nutshell help")
  end
end
