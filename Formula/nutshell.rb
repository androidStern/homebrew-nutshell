class Nutshell < Formula
  desc "Local personal trace ingestion runtime"
  homepage "https://github.com/androidStern/nutshell"
  version "0.1.27"
  license "MIT"

  depends_on macos: :sonoma

  if Hardware::CPU.arm?
    url "https://github.com/androidStern/nutshell/releases/download/v0.1.27/nutshell-0.1.27-darwin-arm64.tar.gz"
    sha256 "045527a082dbc6378d95e4b12925b122c2658d7bb2b7eda46c0e54cafba09a9f"
  else
    url "https://github.com/androidStern/nutshell/releases/download/v0.1.27/nutshell-0.1.27-darwin-x64.tar.gz"
    sha256 "589d1e9bf39eb606190b746ff87ce8e1e1760c073a5717c402774797a2f5c829"
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
