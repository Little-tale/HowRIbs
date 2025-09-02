## Ribs가 왜 나온 것인가
> MVC 를 유지보수 할때에 새로운 기능이 늘어날때마다 복잡성이 증가

- 모듈 증가할 수록 테스트 복잡
- ViewController 평균 코드 줄이 3000줄

### VIPER 아키텍처란 무엇인가
- View              : UI
- Interactor        : 비즈니스 로직 + Network + Data Layer 수행
- Presenter         : UI의 상호작용 -> Interactor의 Data를 요청후 View 반영 담당
- Entity            : UI에 사용할 모델
- Router            : 화면 전환 로직

### Viper 장점
- MVC 대비 추상적
- 각각의 책임 분담으로 인한 유지보수 도움
- 테스트 용이 단 Presenter, Interactor 한

## Ribs는 왜?
- View, Business 트리와 밀접 -> 한쌍을 이루어야 함이 거슬림 -> 단독 노드 구성 가능하게
- View 트리가 중심인점


### VIPER 아키텍처
View <-> Presenter <-> Interactor -> Entity
          |-> Router

### Ribs

Builder <-> Componen
   ↓
┌──────────────────────────────────────────────┐
│ Router <- Interactor <-> Presenter <-> View  │
└──────────────────────────────────────────────┘

