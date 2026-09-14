class CognisExecutor < Formula
  desc "Standalone remote executor for Cognis"
  homepage "https://github.com/fpytloun/cognis"
  if Hardware::CPU.arm?
    url "https://github.com/fpytloun/cognis/releases/download/v0.15.0/cognis-executor-0.15.0-macos-arm64.tar.gz"
    sha256 "0dfb96ba74a6971b64b5f32a622393196e629ca4581ab5ecf33ed943c097dd1f"
  else
    url "https://github.com/fpytloun/cognis/releases/download/v0.15.0/cognis-executor-0.15.0-macos-x86_64.tar.gz"
    sha256 "bbfdec87218ef1708ad0131fc70e05f688208edf99825ffa7ea744cfb490aa5d"
  end

  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "libffi"
  depends_on "node"
  depends_on "pango"
  depends_on "python@3.12"
  depends_on "uv"

  preserve_rpath

  def install
    if build.head?
      system formula_opt_bin("uv")/"uv", "pip", "install", "--prefix", libexec,
             "--python", formula_opt_bin("python@3.12")/"python3.12",
             "packages/common", "packages/executor[full]"
    else
      libexec.install Dir["payload/*"]
    end
    (bin/"cognis-executor").write <<~SH
      #!/bin/bash
      set -euo pipefail
      export PYTHONNOUSERSITE=1
      export PYTHONPATH="#{libexec}/lib/python3.12/site-packages"
      export PATH="#{libexec}/bin:#{opt_bin}:#{formula_opt_bin("python@3.12")}:#{formula_opt_bin("uv")}:#{formula_opt_bin("node")}:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
      exec "#{formula_opt_bin("python@3.12")}/python3.12" -m cognis.executor "$@"
    SH
  end

  def caveats
    <<~EOS
      Configure this executor with:
        cognis-executor configure

      Manage the per-user launchd service with:
        brew services start cognis-executor
        brew services list
        brew services stop cognis-executor
        cognis-executor logs --follow

      Configuration and workspace data stay outside Homebrew's prefix.
    EOS
  end

  service do
    run opt_bin/"cognis-executor"
    keep_alive true
    working_dir Dir.home
    log_path var/"log/cognis-executor.log"
    error_log_path var/"log/cognis-executor.error.log"
    process_type :interactive
  end

  test do
    assert_match "Cognis executor", shell_output("#{bin}/cognis-executor --help")
  end
end
