# TILMemo
블로그로 쓰기에는 짧은 내용을 정리하는 저장소

## Atomic/non Atomic

* atomic - 중단되지 않는

> an operation appears to occur at a single instant between its invocation and its response

* `atomic`하다는 것은 프로그래밍에서 데이터의 변경이 동시에 일어난 것처럼 보이게 하는 것을 의미한다. 데이터의 값을 변경하는 것은 항상 변경하는 시간이 필요하다.  `atomic`한 데이터에 변경이 이뤄질 때는 변경하는 시간에 lock을 건다. 그래서 데이터를 변경하는 시간이 없어보이게(변경시에 아무런 작업이 일어나지 않으므로) 만든다.
* 그래서 property가 `atomic`하다는 것은 멀티 쓰레드 환경에서 데이터가 반드시 변경 전, 변경 후의 상황에서만 접근되도록 하는 것을 보장한다. 즉, 데이터의 변경 중에는 접근이 불가능하다. 바꿔 말하면, `atomic` property는 항상 serial하게 접근된다.
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



## ObjectiveC를 통한 객체 개념 이해
* 객체는 객체끼리 메시지를 주고받으며 일을 처리한다. 메시지는 항상 함수를 trigger하며 이 때 호출되는 함수를 메소드(method)라고 한다.

즉, 어떤 객체의 메소드를 호출하는 것은 

	1. 해당 메소드로 호출되는 함수를 실행한다.
	2. 해당 클래스에 메시지를 보낸다.

의 의미 모두 해당된다.

### 클래스

* 특정 타입의 객체를 설명해놓은 것
* 이 설명에는 메소드와 데이터를 저장하는 장소인 인스턴스 변수도 포함된다.
* 클래스에 의해 힙에 생성된 객체를 인스턴스라고 한다.

### Message

Message는 메시지를 받는 객체의 포인터(receiver)와 트리거될 메소드의 이름(selector)로 구성되어 있다.

#### 메시지 보내기
```objectivec
NSDate *now = [NSDate date];
[now dateByAddingTimeInterval:100];
```
* `now`(receiver): 메시지를 받을 객체의 주소
* `dateByAddingTimeInterval`(selector): 트리거할 메소드의 이름
* 위의 코드는 `NSDate` 클래스에 메시지를 보내서 새 객체가 시작하는 지점의 주소를 `now` 변수에 저장하는 코드이다.

메소드는 메시지를 받는 receiver에 따라 크게 2가지로 나뉜다.

* 클래스 메소드: 클래스에 메시지를 보내는 메소드, receiver가 클래스,  `[NSDate date]`
* 인스턴스 메소드: 인스턴스에 메시지를 보내는 메소드,  receiver가 인스턴스,  `[now dateByAddingTimeInterval:100]`
	
* 참고자료 - [아론 힐리가스의 Objective-C 프로그래밍](https://www.kyobobook.co.kr/product/detailViewKor.laf?mallGb=KOR&ejkGb=KOR&barcode=9788994506401)

## 객체 상속의 구동 방식
* 인스턴스는 객체를 생성할 때 isa라는 포인터를 갖는다. 이 isa 포인터는 인스턴스를 생성한 클래스를 가리키고 있다.
* 클래스 또한 isa 포인터를 갖고 있으며, 이 포인터는 자기자신 혹은 부모 클래스를 가리키고 있다.

*  인스턴스에 전달되는 메시지의 실행 방식
1. 인스턴스는 자신의 isa 포인터를 통해 클래스에 전달받은 메시지를 통해 실행되는 메소드가 있는지 묻는다.(있으면 종료)
2. 없으면, 클래스는 자신의 isa 포인터를 찾고, 부모 클래스에 인스턴스 메소드가 구현되어 있는지 묻는다.
3. 위 과정을 반복하고, 메시지를 처리할 메소드가 있으면 해당 메소드를, 없으면 종료한다.

* 이와 같은 방식으로 메시지가 전달되기 때문에 오버라이딩 된 메소드가 부모 클래스의 메소드보다 우선적으로 수행될 수 있다.


## 객체 소유권(Object Ownership)
* A 객체 안에 B 객체 인스턴스 변수를 포함하고 있을 때 , A는 B 객체를 소유한다(own)고 말한다.
* 누구에게도 소유되지 않은 객체는 메모리에서 해제된다.
* 객체가 Collection에 추가된다면, Collection에는 객체에 대한 포인터가 저장되므로, Collection은 객체를 소유하게 된다.
* 객체가 Collection에서 제거된다면, Collection에서도 객체에 대한 포인터가 제거되어 객체는 소유자를 잃는다.

* property의 strong의 의미 - 객체의 소유권을 주장한다.
```objectivec
@interface Asset : NSObject
// label에 대한 소유권은 Asset이 가지고 있다.
@property (strong) NSString *label;
@end
```

* property의 weak의 의미 - 객체의 소유권을 주장하지 않는다.
```objectivec
@interface Asset : NSObject
// label에 대한 소유권을 Asset이 가지지 않는다.
@property (weak) NSString *label;
@end
```

## Pod install vs Pod update

* pod install - 처음 프로젝트에 pods을 설치할 때 사용한다. 또한 새로운 pods을 추가하거나, 제거할 때도 사용한다.
* pod update - 새로운 버전으로 pods을 올릴 때만 사용한다.
