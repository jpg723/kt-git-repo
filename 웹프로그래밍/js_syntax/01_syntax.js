// Javascript
// 웹브라우저에서 이벤트를 처리하는 문법
/*

[목차]
1. 변수선언 : RAM(메모리) 사용하는 문법
2. 데이터타입 : RAM(메모리)을 효율적으로 사용하는 문법 : 동적타이핑
3. 연산자 : CPU를 사용하는 문법 : 산술연산자, 비교연산자, 논리연산자
4. 조건문 : 조건에 따라서 다른 코드를 실행
5. 반복문 : 특정 코드를 반복적으로 실행
6. 함수 : 중복코드를 묶어서 코드 작성 및 실행
7. 객체 : 식별자 1개에 데이터를 여러 개 저장하는 문법 : 클래스

[특징]
- 인터프리터 언어, 동적타이핑, 객체지향

* 컴파일러 언어(C, Java)
- 전체를 번역 후에 실행하므로 속도가 빠르다.
- 문법의 난이도가 높다. (int a = 10)

* 인터프리터 언어(js, py)
- 컴파일링 과정이 없이 한 줄씩 실행하여 서버를 중단하지 않고 실행가능
- 한 줄씩 번역하면서 읽고 실행하므로 속도가 느리다.
- 문법의 난이도가 쉽다. (a = 10)

!! 데이터분석은 속도가 빠를 수록 좋은데 왜 속도가 느린 파이썬을 주로 사용할까?
- numpy가 c, c++로 만들어짐
- pandas와 sklearn도 numpy로 만들어서 속도가 빠름

*/
//=========================================================================

// 1. 변수 선언
// 식별자 : 저장공간을 구별하는 문자열
// 식별자 규칙 : 대소문자, 숫자, _, $ : 가장 앞에 숫자 X : 예약어 사용X
// 식별자 컨벤션 : camelCase(변수, 함수), PascalCase(모듈)

// [선언 방법]--------------------------------------------
// 식별자 1개, 데이터 1개
var data1 = 10;

// 식별자 n개, 데이터 n개
var data2 = 20, 
    data3 = 30;

// 식별자 n개, 데이터 1개
var data4 = data5 = 40;

console.log(data1, data2, data3, data4, data5);
//=========================================================================

// 2. 데이터타입
// number, string, boolean, function, object
// 동적타이핑 : 데이터타입 선언 없이 자동으로 데이터타입이 정의되는 것
var data1 = 1;
var data2 = 'js';
var data3 = true;
var data4 = function(){console.log('js');};
var data5 = {key: 'js'};

console.log(typeof data1, typeof data2, typeof data3);
console.log(typeof data4, typeof data5);

// [데이터가 없음]--------------------------------------------
// undefined : 선언은 되었으나 데이터가 할당되지 않은 경우
// null : 선언은 되었으나 데이터 없음이 할당
// NaN : Number 데이터 타입에서 undefined
var data1 = undefined;
var data2 = null;
var data3 = NaN;

console.log(typeof data1, data1)
console.log(typeof data2, data2)
console.log(typeof data3, data3)

// [데이터 타입의 형 변환]--------------------------------------------
// Number(), String(), Boolean()
var data1 = '1';
var data2 = 2;

console.log(typeof data1, typeof Number(data1)); // string number
console.log(data1 + data2); // 12
console.log(Number(data1) + data2); // 3
console.log(data1 + String(data2)) // 12

// [묵시적 형 변환]--------------------------------------------
// 서로 다른 데이터타입을 연산할 때 자동으로 데이터 타입을 변경해주는 것
var data1 = '1';
var data2 = 2;
console.log(typeof data1, typeof (data - 0)); // string number
console.log(typeof data2, typeof ('' + data2)); // number string

//=========================================================================

// 3. 연산자 : operator
// [산술연산자]--------------------------------------------
// 데이터 + 데이터 = 데이터
// +, -, *, /, %, **, ++, --
var data1 = 11, data2 = 4;
console.log(data1 / data2, data1 % data2, data2 ** 3); // 2.75, 3, 64

// ++data1: +1하고 데이터 대입
var data1 = 5, data2 = 7;
data1 = ++data2;
console.log(data1, data2); // 8 8

// data1++ : 데이터 대입하고 +1
var data1 = 5, data2 = 7;
data1 = data2++;
console.log(data1); // 7 8

// [비교연산자]-------------------------------------------- 
// 데이터 + 데이터 = 논리값 : 조건 1개
// ==(데이터만 비교), !=, >, <, >=, <=, ===(데이터 타입까지 비교), !==
// ==와 ===
var data1 = 1, data2 = '1';
console.log(data1 == data2, data1 === data2); // true false 

// [논리연산자]-------------------------------------------- 
// 논리값(조건1) + 논리값(조건2) = 논리값 : 조건 2개 이상
// !(not), &&(and : T && T = T), ||(or : F or F = F)
console.log(true && false, true || false) // false true

// 비교 : 조건 1개
// 논리 : 조건 2개 이상
// 예금잔고에서 예금인출이 가능하면 true, 아니면 false
// 조건 1 : 예금잔고 >= 인출금액
var balance = 10000;
var amount = 6000;
console.log(balance >= amount); // true

// 조건 2 : 최대 인출금액 5000원
var balance = 10000;
var amount = 6000; 
console.log(balance >= amount, amount <= 5000); // true false
console.log(balance >= amount && amount <= 5000); // false

// [할당연산자]--------------------------------------------
// 변수 <산술>= 데이터 : 누적해서 연산
var data1 = 10;
data1 += 20;
console.log(datat1) // 30

// [삼항연산자]-------------------------------------------- 
// condition ? true :false
var balance = 10000, amount = 6000;
var msg = balance >= amount ? '인출가능' : '인출불가';
console.log(msg) // 인출가능

// [실수하기 쉬운 코드]--------------------------------------------
// 부동 소수점 에러
var data1 = 0.1, data2 = 0.2;
console.log(data1 + data2 === 0.3); // -> false
console.log(data1 + data2); // 0.300000000000004
console.log((Math.round(data1 + data2) * 10) / 10 === 0.3); // 반올림한 다음 비교 -> true

//=========================================================================

// 4. 조건문
// if, else if, else
var balance = 10000, amount = 6000;
if(balance < amount){
    console.log('인출불가');
} else if(amount > 5000) {
    console.log('인출불가:최대 인출 금액 초과');
} else {
    console.log('인출가능');
}

//=========================================================================

// 5. 반복문
// while, for, break, continue
// [while문]--------------------------------------------
var count = 3;
while(count > 0) {
    count -= 1;
    console.log('js');
}

// [for문]--------------------------------------------
// continue : 실행되면 바복문을 정의하는 코드로 올라가서 코드 실행
// break : 반복중단
for(var i = 0; i < 5; i++){

    if (i === 2){
        continue;
    }
    console.log('js', i);

    if(i >= 3){
        break;
    }
}

// [실습]--------------------------------------------
// 로또 번호 출력 : 1 ~ 45 랜덤한 숫자 6개 출력(문자열), 중복 허용
var count = 6, lotto = '';

for(var i = 0; i < count; i++){
    var random = Math.ceil(Math.random() * 44) + 1; // 1~45까지 랜덤한 숫자
    lotto += random + " ";
}

console.log(lotto);

//=========================================================================

// 6. 함수 : function
// 중복되는 코드를 묶어서 코드 작성 실행 문법 > 코드 유지 보수 향상
// 사용법 : 함수선언(코드작성) > 함수호출(코드실행)
// parameter, argument :  함수 호출하는 코드에서 함수 선언하는 코드로 데이터 전달

// 함수 선언 : 코드작성
function showLotto(count) {
    var lotto = '';

    for(var i = 0; i < count; i++){
        var random = Math.ceil(Math.random() * 50) + 1; // 1~45까지 랜덤한 숫자
        lotto += random + " ";
    }

    console.log(lotto);
}

// 함수호출 : 코드실행
showLotto(7);

// javascript 문자열 출력
console.log('javascript')

// 함수호출 : 코드실행
showLotto(6);

// [함수 선언 방법]--------------------------------------------

// 함수 선언 방법1: 선언식
// 호이스팅: 함수를 호출하고 선언해서 사용 가능
function plus1(n1, n2){
    console.log(n1 + n2);
}
plus1(1, 2);

// 함수 선언 방법2: 표현식
// 함수를 선언하고 사용이 가능
var plus2 = function(n1, n2){
    console.log(n1 + n2);
}
plus2(2, 3);

// [스코프]--------------------------------------------
// 함수 안 : 지역영역 : 지역변수 : local
var data = 10;
function change(){
    var data = 20; // var을 선언하면 local 변수
}
change();
console.log(data); // 10

// 함수 밖 : 전역영역 : 전역변수 : global
var data = 10;
function change(){
    data = 20; // var을 선언하지 않으면 global 변수
}
change();
console.log(data); // 20

// [return]--------------------------------------------
function plus1(n1, n2){
    console.log('plus1', n1 + n2);
    return n1 + n2;
}

function plus2(n1, n2){
    console.log('plus2', n1 + n2);
}

result1 = plus1(2, 3);
result2 = plus2(2, 3);
console.log(result1, result2);

// [익명함수]--------------------------------------------
// 선언과 동시에 호출하는 함수
// 자바스크립트 코드를 웹서비스 사용자가 사용할 수 없도록 하기 위해 사용
(function plus1(n1, n2){
    console.log(n1 + n2);
}(2, 3))

//[defalt parameter 설정]--------------------------------------------
var plus = function(n1, n2){
    n2 = n2 || 10; // n2에 데이터 없으면 10대입
    return n1 + n2;
}
result = plus(1);
console.log(result); // 11

result = plus(1, 2);
console.log(result); // 3

//=========================================================================