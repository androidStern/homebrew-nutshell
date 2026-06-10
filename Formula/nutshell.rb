class Nutshell < Formula
  desc "Local personal trace ingestion runtime"
  homepage "https://github.com/androidStern/nutshell"
  version "0.1.25"
  license "MIT"

  depends_on macos: :sonoma

  on_arm do
    url "https://github.com/androidStern/nutshell/releases/download/v0.1.25/nutshell-0.1.25-darwin-arm64.tar.gz"
    sha256 "4b3269544c1fdec51401ce7d56572765fcff0921b689a749187eabe0480f5940"
  end

  on_intel do
    url "https://github.com/androidStern/nutshell/releases/download/v0.1.25/nutshell-0.1.25-darwin-x64.tar.gz"
    sha256 "b41e9abaa3bc9523cbb92f0eab6ce0a6c531232070297fd5eaa08bafb658c620"
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
