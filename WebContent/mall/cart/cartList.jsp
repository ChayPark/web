<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mall.cart.*, java.util.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
<style>
#container { width: 1100px; margin: 0 auto;}
.title { text-align: center; font-size: 1.5em; margin: 30px 0;}
/* 상품 테이블 */
table { width: 100%; border: 1px solid #868e96; border-collapse: collapse;}
th, td { border: 1px solid #868e96;}
tr { height: 50px;}
.cart_table th { text-align: center;}
ul { width: 100%; list-style: none;}
checkbox { margin: 0; padding: 0;}
input[type="checkbox"] { width: 15px; height: 15px; padding: 10px; cursor: pointer; margin-left: 18px;}
input[type="number"] { width: 50px; margin: 5px; text-align: right; margin-left: 26px;}
#btn_update { width: 60px; height: 30px; margin: 5px; margin-left: 25px; 
background: #ff953f; border: none; color: white; cursor: pointer; font-size: 0.8em; font-weight: bold;}
#btn_update:hover { border: 1px solid #ff953f; color: #ff953f; background: white;}
#btn_buy, #btn_delete { width: 80px; margin: 5px; margin-left: 12px;}
#btn_buy { background: #196ab2; border: none; color: white; cursor: pointer;}
#btn_buy:hover { background: white; border: 1px solid #196ab2; color: #196ab2;}
#btn_delete { background: #c84557; border: none; color: white; cursor: pointer;}
#btn_delete:hover { background: white; border: 1px solid #c84557; color: #c84557;}

.center { text-align: center;}
.left { padding: 10px;}
.right { text-align: right; padding-right: 15px;}

.s_choice { font-size: 0.7em;}
.s_image { float: left;}
.s_title { float: left; font-weight: bold; margin-left: 15px;}
.s_image a, .s_title a { text-decoration: none; color: black;}
.s_day1 { font-size: 1.1em; font-weight: bold;}

/* 총 정보 테이블 */
.cart_table2 th { text-align: center; font-size: 1.2em;}
.first_row { background: #e9ecef;}
.t_price { color: #c84557;}
.btns_row th { padding-left: 280px;}
#btn_delete2, #btn_buy2 { width: 150px; height: 50px; margin: 10px; 
border: none; color: white; font-size: 0.8em; font-weight: bold;}
#btn_delete2 { background: #c84557; margin-right: 200px;}
#btn_delete2:hover { background: white; border: 1px solid #c84557; color: #c84557;}
#btn_buy2 { background: #196ab2; margin-left: 200p;}
#btn_buy2:hover { background: white; border: 1px solid #196ab2; color: #196ab2;}

/* number 타입에서 버튼 항상 보이기 */
input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button {  
   -webkit-appearance: "Always Show Up/Down Arrows"; opacity: 1;}
</style>
<script>
// 과제 : (jQuery)제이쿼리를 사용하여 해결 <- 체크박스를 활용한 카트 선택 문제
var choice_cart = []; // 선택된 카트번호를 저장하는 배열
var choice_count = 0; // 선택된 카트 개수

window.onload = function() {
	var choice_all = document.querySelector("#choice_all");
	var choice_one = document.getElementsByName("choice_one");
	var btn_delete2 = document.querySelector("#btn_delete2");
	var btn_buy2 = document.querySelector("#btn_buy2");
		
	// 전체 선택을 체크하면 -> 선택 상품을 모두 체크, 버튼 2개도 전체 상품으로 변경
	// 전체 선택을 해제하면 -> 선택 상품을 모두 해제, 버튼 2개도 선택 상품으로 변경
	choice_all.addEventListener("change", function() {
		if(choice_all.checked == true) { // 전체 선택
			choice_cart = []; // 카트번호 배열을 초기화, choice_cart.length = 0;
			for(var i=0; i<choice_one.length; i++) {
				choice_one[i].checked = true;
				btn_delete2.value = "전체 상품 삭제";
				btn_buy2.value = "전체 상품 주문";
				choice_cart.push(choice_one[i].value);
				choice_count = choice_one.length; // 선택 카트 개수 = 전체 카트 개수
			}
		} else { // 전체 해제
			choice_cart = []; 
			for(var i=0; i<choice_one.length; i++) {
				choice_one[i].checked = false;
				btn_delete2.value = "선택 상품 삭제";
				btn_buy2.value = "선택 상품 주문";
				choice_count = 0; // 선택 카트 개수 = 0
			}
		}
		console.log(choice_cart)
	})

	// 전체 삭제 또는 선택 삭제 버튼 동작
	btn_delete2.addEventListener("click", function() {
		if(choice_count == 0) {
			alert("카트 상품이 선택되지 않았습니다.\n카트 상품을 선택하세요.");
			return;
		}
		location = 'cartDeletePro2.jsp?choice_cart=' + choice_cart;
	})
	
	// 전체 주문 또는 선택 주문 버튼 동작
	btn_buy2.addEventListener("click", function() {
		
	})
}

// 선택 상품 체크 중에서 하나라도 체크가 해제된다면 -> 전체 상품 체크 해제, 버튼 2개도 선택 상품으로 변경
// 선택 상품 하나씩을 모두 체크한다면 -> 전체 상품 체크, 버튼 2개도 전체 상품으로 변영
function choiceOne(e) {
	if(e.checked == false) { // 개별 카트 선택 해제되었을 때
		choice_all.checked = false;
		btn_delete2.value = "선택 상품 삭제";
		btn_buy2.value = "선택 상품 주문";
		for(var i=0; i<choice_cart.length; i++) {
			if(choice_cart[i] == e.value) {
				choice_cart.splice(i, 1); // 카트 배열에서 카트 번호 삭제
				--choice_count;           // 카트 선택 개수에서 1을 마이너스
			}
		}
	} else { // 개별 카트 선책 체크되었을 때
		choice_cart.push(e.value);        // 카트 배열에 카트 번호 삽입
		++choice_count;                   // 카트 선택 개수에 1을 플러스
	}
	
	var total_count = document.getElementsByName("choice_one").length;
	if(total_count == choice_count) { // 전체 카트 개수 == 선택한 카트 개수
		choice_all.checked = true;
		btn_delete2.value = "전체 상품 삭제";
		btn_buy2.value = "전체 상품 주문";
	}
	console.log(choice_cart);
	console.log("total_count : " + total_count);
	console.log("choice_count : " + choice_count);
}
</script>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");
// 로그인이 되지 않았을 때 -> 로그폼으로 이동
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../member/memberLoginForm.jsp';</script>");
}

// 가격 포맷
DecimalFormat df = new DecimalFormat("#,###,###");

// 배송일자 구하기
// 일월화 = 현재날짜 + 3일, 수목금 = 현재날짜 + 3일 + 2일(토일), 토 = 현재날짜 + 3일 + 1일(일)
Calendar c = Calendar.getInstance();
int diff_day = 3;
// 요일 - 1~7, 일~토
switch(c.get(Calendar.DAY_OF_WEEK)) {
case 1: case 2: case 3: c.add(Calendar.DATE, diff_day); break;
case 4: case 5: case 6: c.add(Calendar.DATE, diff_day+=2); break;
case 7: c.add(Calendar.DATE, diff_day+=1); break;
}
// 배송 월, 일, 요일
int m = c.get(Calendar.MONTH) + 1;   // 배송 월
int d = c.get(Calendar.DATE);        // 배송 일
int w = c.get(Calendar.DAY_OF_WEEK); // 배송 요일
String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"};
String week = weekday[w];
//System.out.println("배송일자 : " + m + "월 " + d + "일 " + weekday[w] + "요일");

// cart DB 연동, 쿼리 실행
CartDBBean cartPro = CartDBBean.getIntance();
int count = cartPro.getCartCount(memberId);  // 장바구니 수량
List<CartDataBean> cartList = cartPro.getCartList(memberId);

//카트 종합 정보 변수
//tot1: 구매 상품 종류, tot2: 총 구매 수량, tot3: 총 구매 금액
int tot1 = count, tot2 = 0, tot3 = 0; 
%>
<div id="container">
<ul>
	<li><header><jsp:include page="../common/shopTop.jsp"/></header></li>
	<li>
		<div class="title">카트 목록</div>
		<table class="cart_table">
			<tr class="first_row">
				<th width="5%"><span class="s_choice">전체선택</span><br><input type="checkbox" name="choice_all" id="choice_all"></th>
				<th width="50%">상품정보</th> <%-- 상품이미지, 상품제목 --%>
				<th width="10%">구매수량</th> <%-- 수량 수정 처리 --%>
				<th width="10%">상품금액</th> <%-- 구매수량을 판매가를 곱한 금액 --%>
				<th width="15%">배송정보</th> <%-- 현재날짜 + 3 --%>
				<th width="10%">주문</th>    <%-- 주문, 삭제 처리 --%>
			</tr>
		<%if(count == 0) {%>
			<tr><th colspan="6">카트에 상품이 없습니다.</th></tr>	
		<%} else {
			for(CartDataBean cart : cartList) {
				tot2 += cart.getBuy_count(); // 총 구매 수량
				tot3 += cart.getBuy_price(); // 총 구매 금액
		%>
			<form method="post" action="cartUpdatePro.jsp" name="cartForm">				
			<tr>
				<input type="hidden" name="cart_id" value="<%=cart.getCart_id() %>">
				<input type="hidden" name="product_id" value="<%=cart.getProduct_id() %>">
				<input type="hidden" name="p_one_price" value="<%=cart.getBuy_price()/cart.getBuy_count() %>"> <%-- 상품1개 가격 --%>
				<td class="center"><input type="checkbox" name="choice_one" id="choice_one" value="<%=cart.getCart_id()%>" onchange="choiceOne(this)"></td>
				<td class="left">
					<span class="s_image"><a href="../shop/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><img src="/images_mall21/<%=cart.getProduct_image()%>" width="50" height="75"></a></span>
					<span class="s_title"><a href="../shop/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><%=cart.getProduct_title() %></a></span>
				</td>
				<td class="center">
					<input type="number" name="buy_count" class="buy_count" value="<%=cart.getBuy_count() %>" min="1" max="100"><br>
					<input type="submit" name="btn_update" id="btn_update" value="변경">
				</td>
				<td class="right">
					<span class="s_price"><%=df.format(cart.getBuy_price()) %>원</span>
				</td>
				<td class="center">
					<span class="s_day1"><%=diff_day %>일 이내</span><br>
					<span class="s_day2">(<%=m %>/<%=d %>, <%=week %>)</span><br>
					<span class="s_day3">출고예정</span>
				</td>
				<td class="center">
					<input type="button" id="btn_buy" value="주문하기" 
						onclick="location='../buy/buyForm.jsp?cart_id=<%=cart.getCart_id()%>'"><br>
					<input type="button" id="btn_delete" value="삭제" 
						onclick="location='cartDeletePro.jsp?cart_id=<%=cart.getCart_id()%>'">
				</td>
			</tr>
			</form>
		<%} }%>
		</table><br><hr><br>
		<%-- 카트 종합 정보 --%>
		<table class="cart_table2">
			<tr class="first_row">
				<th width="33%">구매 상품 종류</th>
				<th width="33%">총 구매 수량</th>
				<th width="34%">총 구매 금액</th>
			</tr>
			<tr>
				<th><%=tot1 %>종</th>
				<th><%=tot2 %>개</th>
				<th><span class="t_price"><%=df.format(tot3) %>원</span></th>
			</tr>
			<tr class="btns_row">
				<th colspan="3">
					<input type="button" id="btn_delete2" value="선택 상품 삭제">
					<input type="button" id="btn_buy2" value="선택 상품 주문">
				</th>
			</tr>
		</table>
	</li>
	<li><footer><jsp:include page="../common/shopBottom.jsp"/></footer></li>
</ul>
</div>

</body>
</html>