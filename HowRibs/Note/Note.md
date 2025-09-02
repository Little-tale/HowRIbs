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

```swift
Builder <-> Component
   ↓
┌──────────────────────────────────────────────┐
│ Router <- Interactor <-> Presenter <-> View  │
└──────────────────────────────────────────────┘
```

# Ribs 의 정의
> UI가 중심이 아닌 Business Logic 중심으로 하겠다!
> State 변화 감지는 Business 단에서 관리 하겠다!
> L "" 는 Scope ( 격리된거죠 ) 를 통해 관리 하겠다!
> 하나의 화면엔 여러 VC 가 이루어질 수 있다!

## Ribs의 필수적 요소
 - Router: Attach (뷰 추가) Detach (뷰 제거)
 - Interactor: 비즈니스 로직 -> Rib 들을 Attach, Detach할지 명령
 - Builder: Rib 생성
 
## 옵션 적인 요소
 - UI:          Layout, Animation
 - Presenter:   Translation Logic - Interactor <-> View
 
### Scope
> 상속처럼 자식에서 부모의 내용을 받아서 사용 가능
> AuthToken 같은거 생각
> State관리는 이친구가 관리
  - Child Rib에서는 Parent Rib의 내용을 이미 가지고 있다고 가정
  
