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

---

## Pointer

> 변수는 상자와 같고, 상자에 담길 내용물의 종류에 따라 상자의 모양을 제각각으로 만든다고 생각하면 이해하기 쉽다. 상자에 담길 내용물은 변수에 저장될 값이고, 상자의 모양은 변수의 타입이다. 이런저런 모양의 상자들은 모눈종이 위에 좌표를 매겨 가지런히 배열해 놓으면 이 가로 세로 좌표로 금방 찾을 수 있다. **포인터란 어떤 상자의 내용물이 다른 어떤 상자가 놓이 곳의 좌표라는 말이다.** 즉, 어떤 상자를 열었더니 그 안에 다른 상자의 좌표가 있더라는 의미다.

포인터는 참조(reference)라고도 부른다. 포인터를 통해서 어떤 주소의 데이터를 읽으면 이를 포인터의 역참조(dereference)라고 한다.

```c
int main(int argc, const char * argv[]) {
    int i = 17;
    int *addr = &i;
    printf("i: %d\n", i);
    printf("addr: %d\n", *addr); // 역참조
    *addr = 123;
    printf("Now i: %d\n", i);
    return 0;
}
```

* Pass By Reference - 데이터의 주소를 함수에 제공하면 함수가 그곳에 데이터를 집어 넣는다.

* 참고자료 - [아론 힐리가스의 Objective-C 프로그래밍](https://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9788994506401)
