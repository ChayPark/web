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
.title { text-align: center; font-size: 2em; margin: 30px 0;}
/*카트 테이블*/
.cart_table th { text-align: center;}
ul { width: 100%; list-style: none;}
checkbox { margin: 0; padding: 0;}
table { width: 100%; border: 1px solid #868e96; border-collapse: collapse;}
th, td { border: 1px solid #868e96;}
tr { height: 50px;}
input[type="checkbox"] { width: 15px; height: 15px; padding: 10px; cursor: pointer; margin-left: 18px;}
input[type="number"] { width: 50px; margin: 5px; text-align: right; margin-left: 15px;}
#btn_update { width: 60px; height: 30px; margin: 5px; margin-left: 15px; 
background: #c7c4c4; border: none; color: white; cursor: pointer; font-size: 0.9em; font-weight: bold;}
#btn_update:hover { border: 1px solid #c7c4c4; color: #c7c4c4; background: white; }
#btn_buy, #btn_delete { width: 80px; margin: 5px; margin-left: 12px; font-weight: bold;}
#btn_buy { background: #c7c4c4; border: none; color: white; cursor: pointer;}
#btn_buy:hover { background: white; border: 1px solid #c7c4c4; color: #c7c4c4; font-weight: bold;}
#btn_delete { background: #c7c4c4; border: none; color: white; cursor: pointer; }
#btn_delete:hover { background: white; border: 1px solid #c7c4c4; color: #c7c4c4; font-weight: bold;}

.center { text-align: center;}
.left { padding: 10px;}
.right { text-align: right; padding-rigt: 15px;}

.s_choice { font-size: 0.7em;}
.s_image { float: left;}
.s_title { float: left; font-weight: bold; margin-left: 15px;}
.s_image a, .s_title a { text-decoration: none; color: black;}
.s_day1 { font-size: 1.1em; font-weight: bold;}

/*총 정보 테이블*/
.cart_table2 th { text-align: center; font-size: 1.2em;}
.first_row { background: #e9ecef;}
.t_price { color: #c84557;}
.btns_row th { padding-left: 300px; }
#btn_delete2, #btn_buy2 { width: 150px; height: 40px; margin: 10px; 
border: none; color: white; font-size: 0.9em; font-weight: bold;}
#btn_delete2 { background: #9f9c9c; margin-right: 200px;}
#btn_buy2 { background: #9f9c9c; margin-left: 200p;}
#btn_buy2:hover { background: white; border: 1px solid #9f9c9c; color: #9f9c9c;}
#btn_delete2:hover { background: white; border: 1px solid #9f9c9c; color: #9f9c9c;}

/*input number 타입에서 버튼 항상 나오게 하는 방법*/
input[type=number]::-webkit-inner-spin-button, input[type=number]::-webkit-outer-spin-button {  
   -webkit-appearance: "Always Show Up/Down Arrows"; opacity: 1;}
</style>
<script>
var choice_cart = [];
window.onload = function() {	
	var choice_all = document.querySelector("#choice_all");	
	var choice_one = document.getElementsByName("choice_one");
	var btn_delete2 = document.querySelector("#btn_delete2");
	var btn_buy2 = document.querySelector("#btn_buy2");
	
	var choice_cart = [];
	
	// 전체 선택을 체크하면 -> 선택 상품을 모두 체크, 버튼 2개도 전체 상품으로 변경
	choice_all.addEventListener("change", function() {
		if(choice_all.checked == true) {
			for(var i=0; i<choice_one.length; i++) {
				choice_one[i].checked = true;
				btn_delete2.value = "전체 상품 선택";
				btn_buy2.value = "전체 상품 주문";
				choice_cart.push(choice_one[i].value);
			}
		} else {
			choice_cart = []; // choice_cart.length = 0;
			for(var i=0; i<choice_one.length; i++) {
				choice_one[i].checked = false;
				btn_delete2.value = "선택 상품 선택";
				btn_buy2.value = "선택 상품 주문";
			}
		}
		console.log(choice_cart)
	})
	
	// 전체 삭제 또는 선택 삭제 버튼 동작 
	
	// 전체 주문ㅁ 또는 선택 주문 버튼 동작
}		
// 선택 상품 체크 중에서 하나라도 체크가 해제된다면 -> 전체 상품 체크 해제, 버튼 2개도 선택 상품으로 변경
// 선택 상품 하나씩을 모두 체크 -> 전체 상품 체크, 버튼 2개도 전체 상품으로 변경
function choiceOne(e) {
	if(e.checked == false) {
		choice_all.checked = false;
		btn_delete2.value = "선택 상품 선택";
		btn_buy2.value = "선택 상품 주문";
			for(var i=0; i<choice_cart.length; i++) {
				if(choice_cart[i] == e.value) choice_cart.splice(i, 1);
			}
		} else {
			choice_cart.push(e.value);				
		}
		
		for(var i=0; choice_one.length; i++) {
			if(choice_one[i].checked == false) {
				
			}
		}
		console.log(choice_cart);
}	
</script>
</head>
<body>
<%
String memberId = (String)session.getAttribute("memberId");

//로그인이 되지 않았을 때 - 로그인 폼으로 이동
if(memberId == null) {
	out.print("<script>alert('로그인을 해주세요.');");
	out.print("location='../member/memberLoginForm.jsp';</script>");
}

//가격 포맷
DecimalFormat df = new DecimalFormat("#,###,###");

//배송 일자 구하기
//월/화 : 현재날짜 + 3일
//수/목/금 : 현재날짜 + 3일 + 2일(토/일은 휴무), 토 = 현재날짜 + 3일 + 1일(일)
Calendar c = Calendar.getInstance();
int diff_day = 3;
//요일 1~7, 일~토
switch(c.get(Calendar.DAY_OF_WEEK)) {
case 1: case 2: case 3: c.add(Calendar.DATE, diff_day); break;
case 4: case 5: case 6: c.add(Calendar.DATE, diff_day+=2); break;
case 7: c.add(Calendar.DATE, diff_day+=1); break;
}
//배송 월, 일, 요일
int m = c.get(Calendar.MONTH) + 1; 	 // 배송 월
int d = c.get(Calendar.DATE); 		 // 배송 일
int w = c.get(Calendar.DAY_OF_WEEK); // 배송 요일
String[] weekday = {"", "일", "월", "화", "수", "목", "금", "토"};
String week = weekday[w];

//System.out.println("오늘 날짜 : " + m + "월" + d + "일" + weekday[week] + "요일");
//System.out.println("배송 날짜 : " + m + "월" + d + "일" + weekday[w] + "요일");

// 카트 종합 정보 변수
// tot1 : 구매 상품 종류, tot2 : 총 구매 수량, tot3 : 총 구매 금액 
int tot1 = 0, tot2 = 0, tot3 = 0;

// Cart DB 연동, 쿼리 실행 
CartDBBean cartPro = CartDBBean.getIntance();
int count = cartPro.getCartCount(memberId);
List<CartDataBean> cartList = cartPro.getCartList(memberId);

%>

<div id="container">
	<ul>
		<li><header><jsp:include page="../common/shopTop.jsp"></jsp:include></header></li>
		<li>
			<div class="title">장바구니 목록</div>
			<table class="cart_table">
				<tr class="first_row">
					<th width="5%"><span class="s_choice">전체선택</span><br><input type="checkbox" name="choice_all" id="choice_all"></th>
					<th width="50%">상품정보</th> <%-- 상품이미지, 상품제목 --%>
					<th width="4%">수량</th> <%-- 수량 수정 처리 --%>
					<th width="6%">사이즈</th>
					<th width="10%">상품금액</th> <%-- 구매수량을 판매가를 곱한 금액 --%>
					<th width="15%">배송정보</th> <%-- 현재날짜 + 3 --%>
					<th width="10%">주문</th>    <%-- 주문, 삭제 처리 --%>
				</tr>
				<%if(count == 0) {%>
					<tr><th colspan="6">카트에 상품이 없습니다.</th></tr>
				<%} else {
					for(CartDataBean cart : cartList) {
						++tot1; // 구매 상품 종류
						tot2 += cart.getBuy_count(); // 총 구매 수량 
						tot3 += cart.getBuy_price(); // 총 구매 금액
				%>
				<form method="post" action="cartUpdatePro.jsp" name="cartForm">
				<tr>
					<input type="hidden" name="cart_id" id="cart_id" value="<%=cart.getCart_id() %>">
					<input type="hidden" name="product_id" value="<%=cart.getProduct_id() %>">
					<input type="hidden" name="p_one_price" value="<%=cart.getBuy_price()/cart.getBuy_count() %>"> <!-- 상품 한개 가격 -->
					<td class="center"><input type="checkbox" name="choice_one" id="choice_one"></td>
					<td class="left">
						<span class="s_image"><a href="../shop/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><img src='<%="/images_shoes21/"+cart.getProduct_image() %>' width="150" height="100"></a></span>
						<span class="s_title"><a href="../shop/shopContent.jsp?product_id=<%=cart.getProduct_id()%>"><%=cart.getProduct_title() %></a></span>
					</td>
					<td class="center">
						<input type="number" name="buy_count" class="buy_count" value="<%=cart.getBuy_count() %>" min="0" max="100"><br>
						<input type="button" name="btn_update" id="btn_update" value="변경">
					</td>
					<td class="center"><%=cart.getProduct_size()%></td>
					<td class="center"><%=df.format(cart.getBuy_price()) %>$</td>
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
					<th>구매 상품 종류</th>
					<th>총 구매 수량</th>
					<th>총 구매 금액</th>
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
		<li><footer><jsp:include page="../common/shopBottom.jsp"></jsp:include></footer></li>
	</ul>
</div>

</body>
</html>