# Readme
![](https://i.imgur.com/D8eljos.png)
# **1. 제목: JuiceMaker🍹**

# **2. 소개💬**
사용자가 버튼을 통해 쥬스를 주문하면 재료를 소모하여 쥬스를 제조합니다.
재료 수정 화면을 통해 부족한 재료를 추가할 수 있습니다.

# **3. 팀원👩‍💻👩‍💻**
|LJ|Som|
|:----:|:-----:|
|![](https://i.imgur.com/7Fovx27.png)|![](https://i.imgur.com/1AzO7gz.png)|

# **4. 타임라인⏳**
## 2022/08/30
- 과일종류와 재고갯수를 저장하는 Fruit 열거형 정의
- 과일재고를 관리하는 과일창고 FruitStore 클래스 정의
- 쥬스 메뉴를 갖는 Juice 열거형 정의
- 과일창고 재고상태 확인 후 예외의 경우 메세지를 출력하는 OrderError 열거형 정의  

## 2022/08/31
- 과일창고에 재고 없는지 여부 확인하는 메서드
- 과일창고에 재고가 필요한만큼 있는지 확인하는 메서드
- 재고부족 메세지 수정

## 2022/09/01
- 초기재고 선언방법 변경

## 2022/09/05
- 과일쥬스 버튼 정의
- 과일 재고 레이블 정의
- 과일쥬스 버튼과 makeJuice 메서드를 연결해주는 tappedOrderButton 메서드 정의
- 과일 재고 변화를 실시간으로 알려줄 Notification Observer 구현
- 재고의 변화를 사용자에게 레이블을 통해 보여줄 displayFruitStock 메서드 정의
- 재고의 초기상태를 사용자에게 보여줄 designateFruitStock 메서드 정의
- FruitStore 객체에서 초기 재고 상태를 ViewController에게 보내줄 updateFruitStock 메서드 정의

## 2022/09/06
- 쥬스 제조 성공을 알리는 showSuccessAlert 메서드 정의
- 쥬스 제조 실패를 알리는 showFailedAlert 메서드 정의
- tappedOrderButton 수정

## 2022/09/10
- 쥬스 재고를 확인하는 checkFruitStock 메서드의 기능분리
- 재고가 비어있는 지 확인하는 checkEmptyStock메서드, 재고가 필요한 만큼 있는 지 확인하는 checkStockAmount 메서드
- Recipe 타입 추가
- 알 수 없는 오류일 경우의 Alert 띄우는 메서드 추가
- 뷰 컨트롤러의 파일명 ViewController을 JuiceMakerViewController로 수정(FruitStockUpViewController 파일명과 톤앤매너 통일)

## 2022/09/12
- 성공 얼럿 이미지 추가

## 2022/09/15
- JuiceMakerViewController의 프로퍼티 은닉화
- FruitStore의 checkStockAmount, changeFruitStock 메서드 변경
- JuiceMaker의 makeJuice, chooseMenu 메서드 변경


# **5. 시각화된 프로젝트 구조📊**
![](https://i.imgur.com/r2tw5Ic.png)


# **6. 실행 화면📱**
|쥬스 제조를 성공했을 때|쥬스 제조를 실패했을 떄|
|:-----------:|:-----------:|
|![과일 제조 성공](https://user-images.githubusercontent.com/94514250/190851111-3b8908b2-e97a-4c74-bd78-82ac9c1800f6.gif)|![제조 실패_아니요](https://user-images.githubusercontent.com/94514250/190851131-7428ba9a-3aac-48e2-8d16-b7d9c11681f2.gif)|
|쥬스 실패했을 때, 과일 재고를 추가|재고 추가 버튼으로 과일 재고를 추가|
|![제조 실패_예](https://user-images.githubusercontent.com/94514250/190851182-343b8e45-c832-4345-864f-95bd7c4dbe15.gif)|![제고 변경](https://user-images.githubusercontent.com/94514250/190851188-4a5e0103-721b-40b3-b39b-93f607891dea.gif)|




# **7. 트러블 슈팅🧐**
- 과일을 2가지 쓰는 음료에 대한 고민: 1개의 과일은 재고가 없고, 나머지 과일만 재고가 있을 경우, 나머지 과일만 차감되는 상황
→ changeFruitStock 메서드를 기능 분리하여 과일의 재고를 체크하고 차감하는 형태로 변경
```swift
func checkStockBeUsed(in juice: Juice) throws {
        for (fruit, amountOfFruit) in juice.recipeOfJuice {
            guard let stock = stock[fruit], stock != 0 else {
                throw OrderError.emptyStock
            }
            guard stock >= amountOfFruit else {
                throw OrderError.outOfStock
            }
        }
    }
    
func changeFruitStock(to juice: Juice) {
    for (fruit, amountOfFruit) in juice.recipeOfJuice {
        if let stock = stock[fruit] {
           self.stock.updateValue(stock - amountOfFruit, forKey: fruit)
        }
    }
}
```
---
- 2가지 이상의 과일이 들어가는 음료를 만들게 될 경우
```swift
// 기존의 코드 
//중략...
  struct Ingredient {
      let first: (Fruit, Int)
      let second: (Fruit, Int)?
  }
    
  var recipeOFJuice: Ingredient {
      switch self {
      case .strawberryJuice:
          return Ingredient(first: (.strawberry, 16), second: nil)
      case .bananaJuice:
          return Ingredient(first: (.banna, 2), second: nil)
      // 중략...
       }
    }
}
```
과일이 들어가는 순서를 `first`와 `second`로 정했기 때문에, 이 구조는 과일이 2가지밖에 들어가지 못 한다. 그래서 `recipeOFJuice`를 딕셔너리 타입으로 구현했다.
```swift
//중략...
    var recipeOfJuice: [Fruit: Int] {
        switch self {
        case .strawberryJuice:
            return [.strawberry: 16]
        case .bananaJuice:
            return [.banana: 2]
       // 중략 ...
        }
    }
}
```
---
- 쥬스 제조에 실패했음에도 과일 재고가 깎이는 오류

```swift
func makeJuice(to order: Juice, in view: JuiceMakerViewController) {
    for (fruit, amountOfFruit) in order.recipeOfJuice.ingredient {
        do {
            let stock = try fruitStorage.checkEmptyStock(to: fruit)
            let remainingStock = try fruitStorage.checkStockAmount(to: stock, with: amountOfFruit)
            fruitStorage.changeFruitStock(to: remainingStock, to: fruit)
            view.showSuccessAlert(to: order) 
            try chooseMenu(to: order, of: stock)
            fruitStorage.changeFruitStock(to: stock, to: amountOfFruit, of: fruit)
            view.showSuccessAlert(to: order)
        } catch OrderError.outOfStock {
            view.showFailedAlert()
        } catch OrderError.emptyStock {
            view.showEmptyStockAlert()
        } catch {
            view.showUnknownErrorAlert()
        }
    }
}
```

do의 for문 안에서 FruitStore의 changeFruitStock을 호출하다보니 과일을 2가지 썼을 경우, '한 가지 과일을 체크하고 재고를 차감 / 나머지 과일을 체크하고 차감'같은 경우로 구현되었다. 

![](https://camo.githubusercontent.com/dcf6b7d15ce7d6d291913ff22a3485d8f31af82903955ef16eb92d11dac68b34/68747470733a2f2f692e696d6775722e636f6d2f777a39366d77342e676966) 

그렇게 구현하다보니, 쥬스가 제조되지 않았음에도 재고가 충분한 과일은 소모되는 문제가 발생하였다.

```swift
// JuiceMaker 타입
func makeJuice(to order: Juice, in view: JuiceMakerViewController) {
    do {
        for (fruit, amountOfFruit) in order.recipeOfJuice.ingredient {
            let stock = try fruitStorage.checkEmptyStock(to: fruit)
            try fruitStorage.checkStockAmount(to: stock, with: amountOfFruit)
        }
        chooseMenu(to: order)
        view.showSuccessAlert(to: order)
    } catch OrderError.outOfStock {
        view.showFailedAlert()
    } catch OrderError.emptyStock {
        view.showEmptyStockAlert()
    } catch {
        view.showUnknownErrorAlert()
    }
}

func chooseMenu(to order: Juice) {
    for (fruit, amountOfFruit) in order.recipeOfJuice.ingredient {
        fruitStorage.changeFruitStock(to: amountOfFruit, of: fruit)
    }
}
```
→ 두 가지 과일을 모두 체크하고 차감하는 방향으로 오류를 수정하였다. `do`의 `for문` 안에서는 `과일 재고를 체크하는 메서드`만 호출해주고, `chooseMenu` 메서드를 통해 `changeFruitStock`을 호출하여 해결했다.

---
- 과일쥬스 주문버튼에 이벤트가 발생했을 때 재고확인, 재고차감 등 이후 진행단계는 동일하고, 일부 메세지와 레시피만 달랐다. 중복된 부분이 많아보였고, 중복되지 않게 코드를 구성하고 싶었다.

    → **고민한 방법 1** : 이 동일한 과정을 따로 함수로 분리할 수 있지않을까 고민했으나 `viewDidLoad`에 구현하기엔 버튼액션이벤트와 동작시점이 다르고, 매개변수도 달랐다.
    
    → **고민한 방법 2** : 버튼에 `tag` 번호를 붙여 구분하여 이벤트를 받는 메서드를 통일하는 방법도 있었다. 이 방법이면 하나의 Action메서드에서 쥬스를 주문할 때 tag에 따라 다르게 주문을 받을 수 있었다. 이 방법으로 해결하였다.

---
- 쥬스메뉴 7개, 쥬스재료종류 5개인 상황에서 쥬스메뉴별 사용할 쥬스재료량을 다르게 초기화해야 했고, 초기화 방법을 고민되었다.
    → **고민한 방법 1 :  `convenient init()`을 사용하는 방법**
  두 가지 종류 이상 과일을 사용하는 과일쥬스만 `조건문`으로 찾고, `초기화`를 다시해주면 된다 생각하였으나 그 이후 다시 한 가지 종류 과일만 사용하는 쥬스를 주문받을 경우 다시 `초기화` 해주어야 하고, 그 `초기화` 시점 코드가 어느 파일 위치에 작성해야 할 지 또한 고민되었다.
  
    → **고민한 방법 2 : `Recipe`는 변하지 않으니 메뉴 7개별로 각각 전부 `초기화`하고, `싱글톤`으로 선언하여 `ViewController`, `JuiceMaker`, `FruitStore`에서 가져와서 사용하는 방법**
	    `싱글톤`은 항상 같은 객체를 전달해야하는데, 프로젝트에서는 과일쥬스 메뉴에 따라 과일사용량(`프로퍼티`)을 다르게 정해줘야 했으므로 여러 메뉴에 사용되는 과일의 경우 값이 메뉴에 따라 바뀌어야 했다. 쥬스 메뉴별 재료 `프로퍼티`를 전부 선언하는 건 논리적으로 맞지 않았다.
        
    → **고민한 방법 3 : Juice열거형에서 쥬스메뉴 별 딕셔너리로 정의하는 방법**
     `ingredient` 딕셔너리로 `recipeOfJuice`를 반환하여 해당 레시피대로 쥬스를 만들도록 구현하였다. 
     
---
- `Recipe` 타입 정의 할 때, 타입을 `Dictionary`/`Tuple`/`Set`/`Array` 중 무엇으로 할지

    → **고민한 방법 1 : `Dictionary`**
    
    메뉴를 `Dictionary`로 선언하여 `key`에 과일종류, `value`에 과일수량을 넣는 방법
    `Dictionary`에 접근하여 과일수량을 알아내야 할 경우, `Key`값을 이용하여 `Value`값을 직관적으로 볼 수 있었다. 과일쥬스를 만들 때 순서는 상관없었으므로 `Dictionary`로 사용하였다.
    → **고민한 방법 2 : `Tuple`**
    다른 타입의 데이터를 하나로 묶어줄 수 있다는 점에서는 적절했지만, 안에 있는 값에 접근하기 위해선 `Tuple`을 다시 `Array`로 받은 뒤 `Array`의 `index` 번호로 접근해야 해서 사용하지 않았다.
    → **고민한 방법 3 : `Set`**
    중복값을 허용하지 않는 점에서는 납득이 되었지만, 과일재료량은 `Integer`, 쥬스 메뉴명은 `String`으로 다른 타입을 담을 수 없는 점, 순서없이 하나의 묶음으로 저장하므로 값에 접근할 수 있는 방법을 찾지 못한 점 등의 이유로 사용하지 않았다.

---
- 화면이동 방식
     → **고민한 방법 1 : 내비게이션 방식**
     내비게이션 방식은 화면전환되었을 때 다른 카테고리의 데이터로 구성된 화면을 보여주는 경우, 이전화면과 연관되지 않은 경우 내비게이션방식으로 이동한다고 생각했다.
     → **고민한 방법 2 : 모달 방식**
    모달 방식은 이동 후 화면의 데이터를 이동 전 화면과 주고받아야하는 경우여서 모달 방식으로 이동하였다.
---





# **8. 참고 링크🙇‍♀️**
[Swift Language Guide - Nested Types](https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html)
[Swift Language Guide - Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)
[Steppers](https://developer.apple.com/design/human-interface-guidelines/components/selection-and-input/steppers)
[Auto Layout Guide](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html)
[UIViewController - performSegue](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621413-performsegue)
