FROM gitpod/workspace-base

# Install dependencies *You don't need all of them
RUN sudo apt-get update -y \
    && sudo apt-get upgrade -y \
    && sudo apt-get install -y git jq bc make automake \
    && sudo apt-get install -y rsync htop curl build-essential \
    && sudo apt-get install -y pkg-config libffi-dev libgmp-dev \
    && sudo apt-get install -y libssl-dev libtinfo-dev libsystemd-dev \
    && sudo apt-get install -y zlib1g-dev make g++ wget libncursesw5 libtool autoconf \
    && sudo apt-get clean

# Install ghcup
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
RUN bash -c "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
#RUN bash -c "curl -sSL https://get.haskellstack.org/ | sh"

# Add ghcup to PATH
ENV PATH=${PATH}:/root/.local/bin
ENV PATH=${PATH}:/root/.ghcup/bin
ENV PATH=$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH

RUN bash -c "source $HOME/.ghcup/env"
RUN bash -c "source $HOME/.bashrc"

# Install cabal
RUN bash -c "source $HOME/.ghcup/env && ghcup upgrade"
RUN bash -c "ghcup install cabal 3.4.0.0"
RUN bash -c "ghcup set cabal 3.4.0.0"

# Install GHC
RUN bash -c "ghcup install ghc 8.10.4"
RUN bash -c "ghcup set ghc 8.10.4"

# Update Path to include Cabal and GHC exports
RUN bash -c "echo PATH="$HOME/.local/bin:$PATH" >> $HOME/.bashrc"
RUN bash -c "echo export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> $HOME/.bashrc"
RUN bash -c "source $HOME/.bashrc"
