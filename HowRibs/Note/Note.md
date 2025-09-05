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
  
### Ribs Life cycle
> Attach, Detach 상태가 존재하는데
> Router에서 애니메이션 설정이 필요함
> Router에 Will, did 라이프 사이클을 추가하여 사용하면 편리

### Ribs의 단점
> 하나의 기능에 많은 클래수 수와 하나의 파일에 여러가지 클래스가 존재
> Ribs를 하나의 프로젝트에 전체를 종속 시켜야 하는 문제
> Ribs 내부에 RxSwift가 내장되어 있는데 이것 또한 문제


## Parent 와 자식 간의 데이터 교환시
> Interface Listener 사용하여 소통함


# Ribs 생성 방법
 - Rib 생성
 - 부모의 Router에 프로퍼티 적용: 생성된 Child Builder 프로퍼티 추가
 - Dependency적용: Builder를 만들떄에 Componenet 주입
                  컴포넌트는 부모의 컴포넌트 속성을 따름
 - Builder 에 변경된 Router 내용 적용
 
 ## Ribs의 구성 상세
 
 ### Interactor
 > 비즈니스 로직을 포함
 > 해당 클래스에서 Rx 구독을 수행해야함
 > 상태를 변경하는 결정을 수행
 > 그외에 다른 Rib을 자식으로 연결할지 결정함
 
 ### Router
 > Interactor의 요청을 수신 받음
 > 자식 Rib의 연결 혹은 분리

    1. 라우터는 자식 Interactor를 모의하거나 그 존재에 신경 쓸 필요 없이
       복잡한 Interactor 논리를 쉽게 테스트할 수 있게 해주는
       Humble Objects 역할을 합니다.
    2. 라우터는 부모 인터랙터와 자식 인터랙터 사이에 추가적인 추상화 계층을 생성합니다.
       이로 인해 인터랙터 간의 동기식 통신이 다소 어려워지고,
       RIB 간의 직접 결합 대신 반응형 통신을 채택하는 것이 용이해집니다.
    3. 라우터는 인터랙터에서 구현해야 하는 간단하고 반복적인 라우팅 로직을 포함합니다.
       이러한 보일러플레이트 코드를 제거하면 인터랙터의 크기를 줄이고
       RIB에서 제공하는 핵심 비즈니스 로직에 더 집중할 수 있습니다.

### Builder
> RIB의 모든 구성 클래스, 각 자식에 대한 빌더를 인스턴스화

### Presenter
> 비즈니스 모델을 뷰 모델로 변환 혹은
> 반대로 변환하는 상태를 저장하지 않는 클래스
> 해당 클래스는 생략이 가능하며 뷰모델 변환은 뷰컨트롤러 혹은 인터랙터 책임

### View(Controller)
> UI 업데이트 혹은 빌드

### Component
> Rib 종속성 관리
> Rib을 구성하는 다른 유닛들을 인스턴스화 할 수 있도록 지원
> 외부 종속성에 대한 접근을 제공
> 부모 Rib의 컴포넌트는 일반적으로 자식 RIB의 빌더에 주입되어 자식 RIB이
> 부모 Rib의 종속성에 접근하도록 함
