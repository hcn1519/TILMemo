# TILMemo
블로그로 쓰기에는 짧은 내용을 정리하는 저장소

## Atomic/non Atomic

* atomic - 중단되지 않는

> an operation appears to occur at a single instant between its invocation and its response

* `atomic`하다는 것은 프로그래밍에서 데이터의 변경이 동시에 일어난 것처럼 보이게 하는 것을 의미한다. 데이터의 값을 변경하는 것은 항상 변경하는 시간이 필요하다. 하지만, `atomic`은 그 중간에 변경이 필요한 시간을 lock을 걸어서 데이터를 변경하는 시간이 없어보이게(변경시에 아무런 작업이 일어나지 않으므로) 만드는 것을 의미한다.
* 그래서 property가 `atomic`하다는 것은 멀티 쓰레드 환경에서 데이터가 반드시 변경 전, 변경 후의 상황에서만 접근되도록 하는 것을 보장한다. 데이터의 변경 중에는 접근이 불가능하다. 바꿔 말하면, `atomic` property는 항상 serial하게 접근된다.
* `atomic` property라는 것은 `atomic` setter를 갖는 것을 의미한다. 즉, 해당 property의 setter가 동작하고 있을 때는 `atomic` property의 접근이 불가능하다.
---

* ObjectiveC Property는 기본적으로 `atomic`으로 선언된다. 다만, `atomic` property는 property 접근을 block하는 로직을 갖고 있기 때문에 성능이 느린 경향이 있다. 그래서 많은 ObjectiveC Property에는 `nonatomic`이 쓰여 있다.
* Swift는 Thread-Safe를 고려하고 디자인한 언어가 아니기 때문에 모든 property는 non`atomic`이며 별도로 `atomic`도 지정할 수 없다.(GCD를 통해 적절히 컨트롤 해야한다.)
