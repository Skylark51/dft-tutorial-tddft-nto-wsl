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

## 승인된 입력 · 2026-11-17

```text
# B3LYP/def2SVP Opt
```

```text
# B3LYP/def2SVP TD=(NStates=8) Geom=Check

s-trans-1,3-butadiene TD-DFT

0 1

```

```text
# B3LYP/def2SVP Geom=Check Guess=(Read,Only)
  Density=(Check,Transition=1) Pop=SaveNTO

s-trans-1,3-butadiene NTO S1

0 1

```

v1.0.2 설치기가 승인된 입력과 검증기를 설치합니다. 기존 작업 폴더에 들어가면 기본 입력을 한 번 갱신하며,
이전 입력은 `.input-backups/geom-check-nstates8-minimal-v1/`에 보관합니다.
이후 학생이 수정한 입력과 기존 체크포인트·결과 파일을 유지합니다.
