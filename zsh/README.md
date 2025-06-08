# zsh

- [`zsh`](https://www.zsh.org/)
- [`oh-my-zsh`](https://ohmyz.sh/)
- [`powerlevel10k`](https://github.com/romkatv/powerlevel10k)
- [`zhs-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)
- [`syntax-highlighting`](https://github.com/zsh-users/zsh-autosuggestions)

컨테이너 터미널의 편리한 사용을 위해 `zsh`과 주요 플러그인을 설치하는 Dockrefile들  
기본적으로 사용하는 터미널이 `zsh`및 `powerlevel10k`를 사용하기 적합한 환경이어야 함

---

### powerlevel10k

`.p10k.zsh`파일이 있으면 마지막줄 주석 해제
파일이 없으면 자동으로 처음 터미널 실행시 `p10k configure` 명령어 실행

```Dockerfile
...
if [[ ! -f ~/.p10k.zsh ]]; then
  p10k configure
else
  source ~/.p10k.zsh
fi
EOF

# COPY .p10k.zsh /root/    <<< 파일 존재시 주석 해제
```

---

### Command

이미지 빌드

```bash
docker build -t {이미지명} -f Dockerfile.node22.zsh .
```

터미널 진입

```bash
docker run -it --rm {이미지이름} zsh
```

- `--rm`: 컨테이너 종료시 자동 삭제
