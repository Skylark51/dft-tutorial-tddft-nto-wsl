# TD-DFT / NTO 실습

Windows CMD에서 설치하고 시작한다.

```cmd
curl -fsSL https://raw.githubusercontent.com/Skylark51/dft-tutorial-tddft-nto-wsl/main/start.cmd -o "%TEMP%\dft-tddft-start.cmd" && call "%TEMP%\dft-tddft-start.cmd"
```

Ubuntu WSL에서는 다음 명령을 사용한다.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Skylark51/dft-tutorial-tddft-nto-wsl/main/start.sh)
```

## 실습 순서

```bash
cat butadiene-td.inp
g16 < butadiene-td.inp > butadiene-td.out
grep 'Excited State' butadiene-td.out
vi -R butadiene-td.out
cat butadiene-nto.inp
g16 < butadiene-nto.inp > butadiene-nto.out
grep -A 5 'Natural Transition Orbital Coefficients' butadiene-nto.out
nto-view
nto-analysis
```

`g16`은 입력과 단계 연결을 확인한 뒤 **5초 대기하고 라이온 서버에서 미리 계산한 Gaussian 원본 .out을 그대로 출력**한다. `>`로 지정한 파일에는 서버 원본과 동일한 바이트가 저장된다. 출력 앞뒤에 안내 문구를 붙이지 않는다. 원본은 설치본 `data/raw/`, 출처와 SHA256은 `data/lion-provenance.json`에 있다.

모델은 s-trans-1,3-butadiene, B3LYP/def2-SVP, 중성 singlet이다. 승인된 아래 입력으로 2026-11-17 라이온의 lion7에서 Gaussian 16 B.01 계산을 수행했다.

```text
# B3LYP/def2SVP Opt
# B3LYP/def2SVP TD=(NStates=8) Geom=Check
# B3LYP/def2SVP Geom=Check Guess=(Read,Only)
  Density=(Check,Transition=1) Pop=SaveNTO
```

Opt, TD 8상태, NTO S1 및 비교용 S2의 원본 출력을 제공한다. WSL 실습은 준비된 S0 단계 표식에서 TD와 NTO를 각 한 번 실행한다. 전체 순서는 `g16 < butadiene-opt.inp > butadiene-opt.out`부터 시작한다. 실습 .chk는 단계 확인용 JSON이며, 실제 계산의 .fchk와 cubegen 원본은 `data/raw/`에 보관한다.

TD S1: 5.9413 eV, 208.68 nm, f=0.6717. 표의 TD 값은 원본 .out의 인쇄 정밀도를 따른다. NTO 그림은 라이온 Gaussian NTO 체크포인트에서 formchk와 cubegen으로 생성한 MO15(hole), MO16(particle)을 사용한다. 정규화한 NTO 비중은 원본 .fchk의 점유 NTO 고유값을 그 합으로 나눈 값이다. `nto-analysis`로 CSV와 그림을 저장한다. 색은 오비탈 위상을 나타낸다.

`nto-view`에서 1/2로 hole/particle을 전환하고 방향키로 회전하며 q로 종료한다.

v1.0.3 설치 경로는 `~/.local/share/dft-tddft/v1.0.3`이다. 기존 폴더 이름으로 다시 들어가 실습을 이어간다. 입력 변경 시 이전 기본 입력은 `.input-backups/`에 보관한다.

## 강사용 검증

`python3 tests/test_tddft_lesson.py`로 원본 SHA256, 입력 검증, 5초 지연 및 출력 바이트 일치, 설치/재설치, 분석과 뷰어를 검증한다. `build_lion_dataset.py`는 내려받은 원본 .out/.fchk/.cube에서 분석 자료를 만든다. 이후 `build_installer.py`, `build_delivery.py`를 실행한다.

참고문헌: Silva-Junior et al., JCP 129, 104103 (2008), DOI 10.1063/1.2973541; Martin, JCP 118, 4775–4777 (2003), DOI 10.1063/1.1558471.
