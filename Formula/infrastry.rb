class Infrastry < Formula
  desc "Deploy and operate Infrastry applications from the terminal"
  homepage "https://infrastry.ai"
  url "https://github.com/InfrastryAI/infra/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e56b0374b80fc1f67e7ef976ccbf4cfa33f264848a9d4aabb58d020cc62a85e0"
  license "MIT"

  head "https://github.com/InfrastryAI/infra.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-X main.version=#{version}"

    system "go", "build", "-buildvcs=false",
           *std_go_args(output: bin/"infra", ldflags:)

    generate_completions_from_executable bin/"infra", "completion"
  end

  test do
    assert_match "infra #{version}", shell_output("#{bin}/infra version")
    assert_match "Manage Infrastry authentication", shell_output("#{bin}/infra --help")
  end
end
