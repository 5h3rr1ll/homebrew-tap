class Acab < Formula
  desc "Switch between multiple AWS config files and profiles with fzf"
  homepage "https://github.com/5h3rr1ll/acab"
  url "https://github.com/5h3rr1ll/acab/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "748800eae93d1eaa4be3155610e36d20d529ddb26351e296fa1ea822df330ab5"
  license "MIT"
  head "https://github.com/5h3rr1ll/acab.git", branch: "main"

  depends_on "fzf"

  def install
    bin.install "acab"
  end

  def caveats
    <<~EOS
      acab changes variables in your current shell, so it needs a small shell function.
      Add one line to your rc file:

        zsh  (~/.zshrc, after compinit / Oh My Zsh):  eval "$(acab init zsh)"
        bash (~/.bashrc):                              eval "$(acab init bash)"
    EOS
  end

  test do
    assert_match "acab #{version}", shell_output("#{bin}/acab --version 2>&1")

    (testpath/".aws/config-test").write <<~EOS
      [sso-session corp]
      sso_region = eu-central-1

      [profile dev]
      sso_account_id = 111122223333
    EOS
    output = shell_output("#{bin}/acab test 111122223333 2>/dev/null")
    assert_match "export AWS_PROFILE=dev", output
    refute_match "sso-session", shell_output("#{bin}/acab __list-profiles config-test")
    assert_match "acab()", shell_output("#{bin}/acab init zsh")
  end
end
