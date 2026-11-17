# TD-DFT / NTO 실습

Windows CMD에 한 줄을 붙여넣으면 Ubuntu WSL 확인, 실습 설치, 실습 환경 실행이 이어집니다.

```cmd
curl -fsSL https://raw.githubusercontent.com/Skylark51/dft-tutorial-tddft-nto-wsl/main/start.cmd -o "%TEMP%\dft-tddft-start.cmd" && call "%TEMP%\dft-tddft-start.cmd"
```

Ubuntu WSL에서는 다음 명령으로 시작합니다.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Skylark51/dft-tutorial-tddft-nto-wsl/main/start.sh)
```

WSL을 처음 설정하는 PC는 Windows의 관리자 승인·재부팅·Ubuntu 사용자 생성 안내를 따릅니다.
Python 3와 vi는 필요한 경우 Ubuntu 패키지 관리자로 설치합니다.
실습 패키지는 SHA256 확인 후 각 사용자의 홈에 설치되며, 기존 실습 파일을 보존합니다.

## 실습 순서

1. 실습 폴더 이름을 입력합니다.
2. `g16 < butadiene-td.inp > butadiene-td.out`
3. `grep 'Excited State' butadiene-td.out`
4. `g16 < butadiene-nto.inp > butadiene-nto.out`
5. `nto-view` (1 hole / 2 particle / 방향키 회전 / q 종료)
6. `nto-analysis` (CSV와 그림 저장)

모델은 s-trans-1,3-butadiene이며, 준비된 S₀ 참조 구조에서 TD와 NTO를 각각 한 번 실행합니다.
실습 g16은 입력과 단계 연결을 검증하고 PySCF 2.15.0 B3LYP/def2-SVP 참조를 재생하는 교육용 명령입니다.
실습 checkpoint는 JSON 단계 표식입니다. NTO는 real RKS X+Y의 SVD와 정규화한 제곱 특이값을 사용합니다.

참고문헌: [TD-DFT benchmark](https://doi.org/10.1063/1.2973541),
[Natural transition orbitals](https://doi.org/10.1063/1.1558471),
[PySCF TDDFT documentation](https://pyscf.org/user/tddft.html).
