# Please only update to versions that are published on PyPi as there are too
# many releases for us to update to every single one:
# https://pypi.python.org/pypi/youtube_dl
class YoutubeDl < Formula
  desc "Download YouTube videos from the command-line"
  homepage "https://rg3.github.io/youtube-dl/"
  url "https://yt-dl.org/downloads/2015.12.29/youtube-dl-2015.12.29.tar.gz"
  sha256 "4ff67c9cb65f36f0409dc2f35953fe1b66164512c06d46ebb345cb8a70e46208"

  bottle do
    cellar :any_skip_relocation
    sha256 "5d8593f5a27a2fcbb2fed85d9c5e6a6c44309d3a2ef9219bfb0d172aaca2539a" => :el_capitan
    sha256 "6f88288b9df9cfecd5d419b862a73003d57940b507f4be9fc65807a5dfa300cf" => :yosemite
    sha256 "86d14db7bf7190f5daa69f28421cb3bc36bddef2ef37687a7ca13251be8d447a" => :mavericks
  end

  head do
    url "https://github.com/rg3/youtube-dl.git"
    depends_on "pandoc" => :build
  end

  depends_on "rtmpdump" => :optional

  def install
    system "make", "PREFIX=#{prefix}"
    bin.install "youtube-dl"
    man1.install "youtube-dl.1"
    bash_completion.install "youtube-dl.bash-completion"
    zsh_completion.install "youtube-dl.zsh" => "_youtube-dl"
    fish_completion.install "youtube-dl.fish"
  end

  def caveats
    "To use post-processing options, `brew install ffmpeg` or `brew install libav`."
  end

  test do
    system "#{bin}/youtube-dl", "--simulate", "https://www.youtube.com/watch?v=he2a4xK8ctk"
    system "#{bin}/youtube-dl", "--simulate", "--yes-playlist", "https://www.youtube.com/watch?v=AEhULv4ruL4&list=PLZdCLR02grLrl5ie970A24kvti21hGiOf"
  end
end
