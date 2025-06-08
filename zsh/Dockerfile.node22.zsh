# 사용할 기본 이미지
FROM node:22-alpine

# 환경 변수 설정
ENV ZSH_CUSTOM=/root/.oh-my-zsh/custom

# apk 업데이트 및 필요한 패키지 설치
RUN apk update && apk add --no-cache \
    git \
    curl \
    zsh \
    ncurses \
    fontconfig \
    bash \
    shadow \
    && rm -rf /var/cache/apk/*

# oh-my-zsh 설치 (루트 사용자로 설정)
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    chsh -s $(which zsh) root

# Powerlevel10k 테마 설치
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k

# zsh-autosuggestions 플러그인 설치
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting 플러그인 설치
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting

# .zshrc 파일 설정
# 기존 .zshrc 백업 후 새로운 설정 추가
RUN mv /root/.zshrc /root/.zshrc.bak && \
    cat <<EOF > /root/.zshrc
export ZSH="/root/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source \$ZSH/oh-my-zsh.sh

# .p10k.zsh 파일 없으면 최초 실행시 p10k 설정 실행
if [[ ! -f ~/.p10k.zsh ]]; then
  p10k configure
else
  source ~/.p10k.zsh
fi
EOF

# P10k 설정 파일(.p10k.zsh)이 있으면 주석 해제
COPY .p10k.zsh /root/
