class Temporal < Formula
  desc "Command-line interface for running and interacting with Temporal Server and UI"
  homepage "https://temporal.io/"
  url "https://github.com/temporalio/cli/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "9cc4e80254e95a3b456e7d605b518c1a3e4d62b92a08a05efd6cf897ce4b2f3e"
  license "MIT"
  head "https://github.com/temporalio/cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "77a10a2c0b2c92345f5b8b529732a99c27441eb6534876821196d7bd580fa5d4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "77a10a2c0b2c92345f5b8b529732a99c27441eb6534876821196d7bd580fa5d4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "77a10a2c0b2c92345f5b8b529732a99c27441eb6534876821196d7bd580fa5d4"
    sha256 cellar: :any_skip_relocation, ventura:        "f319e2022ffeacef44573a6e12af55cba80d974ea3d26226ec1cfa53e8f47d36"
    sha256 cellar: :any_skip_relocation, monterey:       "f319e2022ffeacef44573a6e12af55cba80d974ea3d26226ec1cfa53e8f47d36"
    sha256 cellar: :any_skip_relocation, big_sur:        "f319e2022ffeacef44573a6e12af55cba80d974ea3d26226ec1cfa53e8f47d36"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0fd2186b35563f054ade9d57f33355b69fa2a6a5e19e13f767a82bec086f3ece"
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/temporalio/cli/headers.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/temporal"
  end

  service do
    args = [
      "server", 
      "start-dev",
      "--db-filename=#{var}/temporal/temporal.db",
      "--dynamic-config-value frontend.workerVersioningDataAPIs=true",
      "--dynamic-config-value frontend.workerVersioningWorkflowAPIs=true",
      "--dynamic-config-value worker.buildIdScavengerEnabled=true",
      "--db-filename=$(brew --prefix)/var/temporal/temporal.db"
     ]
    run [opt_bin/"temporal"] + args
    working_dir var
    keep_alive true
    log_path var/"log/temporal.log"
    error_log_path var/"log/temporal.err"
  end


  test do
    run_output = shell_output("#{bin}/temporal --version")
    assert_match "temporal version #{version}", run_output

    run_output = shell_output("#{bin}/temporal workflow list --address 192.0.2.0:1234 2>&1", 1)
    assert_match "failed reaching server", run_output
  end
end
