class Opencli < Formula
  desc "OpenCLI local AI command line interface"
  homepage "https://github.com/openclirun/opencli"
  version "0.1.0"


  depends_on arch: :arm64
  depends_on macos: :sonoma

  url "https://github.com/openclirun/opencli/releases/download/v0.1.0/opencli-0.1.0-macos-arm64.tar.gz"
  sha256 "d77bcc21adab0767699782e9cba408a2367c833ce1ea44fe5421e21bea403d12"

  def install
    libexec.install "opencli"
    Dir["*.bundle"].sort.each do |bundle|
      libexec.install bundle
    end

    (bin/"opencli").write_env_script(libexec/"opencli", {})
  end

  test do
    assert_match "OpenCLI local AI command line interface", shell_output("#{bin}/opencli --help")
    output = shell_output("#{bin}/opencli model list --task chat --limit 1")
    assert_match "chat", output.downcase
  end
end
