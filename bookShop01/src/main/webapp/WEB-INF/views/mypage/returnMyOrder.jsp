<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	 
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<c:if test="${message=='cancel_order'}">
	<script>
	window.onload=function()
	{
	  init();
	}
	
	function init(){
		alert("주문을 취소했습니다.");
	}
	</script>
</c:if>
<script>
function fn_cancel_order(order_id){
	var answer=confirm("주문을 취소하시겠습니까?");
	if(answer==true){
		var formObj=document.createElement("form");
		var i_order_id = document.createElement("input"); 
	    
	    i_order_id.name="order_id";
	    i_order_id.value=order_id;
		
	    formObj.appendChild(i_order_id);
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/mypage/cancelMyOrder.do";
	    formObj.submit();	
	}
}
function fn_exchange_order(order_id){
	var answer=confirm("교환하시겠습니까?");
	if(answer==true){
		var checkNum = 0;    //  교환할 상품이 체크된 갯수
		var formObj=document.frm;
		var num = formObj.goods_id.length;
	
		var i_order_id = document.createElement("input"); 
	    
	    i_order_id.name="order_id";
	    i_order_id.value=order_id;
	    		
		formObj.appendChild(i_order_id);
		
		var i_exchange_status_code = document.createElement("input")
		i_exchange_status_code.name ="exchange_status_code";
		i_exchange_status_code.value = "exchange_req"   // 교환신청 코드
		
		formObj.appendChild(i_exchange_status_code);
		
	//	alert( "주문번호 : " +  order_id );
		for(i=0;i<num; i++)
		{
			if ( formObj.goods_id[i].checked == true )
			{
		//		alert( "상품코드:" + formObj.goods_id[i].value  + "상품수량:" + formObj.order_goods_qty[i].value);
				checkNum++;
			}
		}
		
		if ( checkNum < 1 ) 
		{
	    	alert("교환할 상품을 1개이상 체크해 주세요");
			return false;
		}		
		
		if ( formObj.returnReason.value =="" )
		{
			alert("교환사유를 선택해 주세요");
			return false;
		}		
		
	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/mypage/addExChangeMyOrder.do";	   
	    formObj.submit();	
		
	}
}

function fn_return_order(order_id){
	var answer=confirm("반품하시겠습니까?");
	if(answer==true){
		var checkNum = 0;    //  반품할 상품이 체크된 갯수
		var formObj=document.frm;
		var num = formObj.goods_id.length;
		
	//	alert("체크상품" + num);
		var i_order_id = document.createElement("input"); 
	    
	    i_order_id.name="order_id";
	    i_order_id.value=order_id;
		
	    formObj.appendChild(i_order_id);
		
		var i_return_status_code = document.createElement("input")
		i_return_status_code.name ="return_status_code";
		i_return_status_code.value = "return_req"   // 반품신청 코드
		formObj.appendChild(i_return_status_code);			
		
		if (num == undefined )  // 상품이 한개인 경우
		{			
			if ( formObj.goods_id.checked == true )	checkNum++;
		}
		else{
			for(i=0;i<num; i++)
			{
				if ( formObj.goods_id[i].checked == true )
				{
				//	alert( "상품코드:" + formObj.goods_id[i].value  + "상품수량:" + formObj.order_goods_qty[i].value);
					checkNum++;
				}
			}
		}	
				
		if ( checkNum < 1 ) 
		{
	    	alert("반품할 상품을 1개이상 체크해 주세요");
			return false;
		}		
		
		if ( formObj.returnReason.value =="" )
		{
			alert("반품사유를 선택해 주세요");
			return false;
		}		
		
   	    document.body.appendChild(formObj); 
	    formObj.method="post";
	    formObj.action="${contextPath}/mypage/addReturnMyOrder.do";	    								      
	    formObj.submit();	
	}
}

<!-- 상품 선택 체크박스용 -->
function calcGoodsPrice(bookPrice,obj){
	var totalPrice,final_total_price,totalNum;
	var goods_qty=document.getElementById("select_goods_qty");
	//alert("총 상품금액"+goods_qty.value);
	var p_totalNum=document.getElementById("p_totalNum");
	var p_totalPrice=document.getElementById("p_totalPrice");
	var p_final_totalPrice=document.getElementById("p_final_totalPrice");
	var h_totalNum=document.getElementById("h_totalNum");
	var h_totalPrice=document.getElementById("h_totalPrice");
	var h_totalDelivery=document.getElementById("h_totalDelivery");
	var h_final_total_price=document.getElementById("h_final_totalPrice");
	if(obj.checked==true){
	//	alert("체크 했음")
		
		totalNum=Number(h_totalNum.value)+Number(goods_qty.value);
		//alert("totalNum:"+totalNum);
		totalPrice=Number(h_totalPrice.value)+Number(goods_qty.value*bookPrice);
		//alert("totalPrice:"+totalPrice);
		final_total_price=totalPrice+Number(h_totalDelivery.value);
		//alert("final_total_price:"+final_total_price);

	}else{
	//	alert("h_totalNum.value:"+h_totalNum.value);
		totalNum=Number(h_totalNum.value)-Number(goods_qty.value);
	//	alert("totalNum:"+ totalNum);
		totalPrice=Number(h_totalPrice.value)-Number(goods_qty.value)*bookPrice;
	//	alert("totalPrice="+totalPrice);
		final_total_price=totalPrice-Number(h_totalDelivery.value);
	//	alert("final_total_price:"+final_total_price);
	}
	
	h_totalNum.value=totalNum;
	
	h_totalPrice.value=totalPrice;
	h_final_total_price.value=final_total_price;
	
	p_totalNum.innerHTML=totalNum;
	p_totalPrice.innerHTML=totalPrice;
	p_final_totalPrice.innerHTML=final_total_price;
}
   // 금액을 3자리 콤마 표시로 표시 by Dean
   function myListener(obj, price, obj2) { 		
		money = obj.value * price;		

		val = document.getElementById(obj2);			
		val.innerHTML = money.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",") + "원";		
    }
	
</script>
</head>
<body>

<h1>반품 내역 조회
    <A href="#"> <IMG  src="${contextPath}/resources/image/btn_more_see.jpg">  </A> 
</h1>

<form name="frm" method="post">

<table>
         <c:choose>
             <c:when test="${ empty myOrderList  }">
              <tr>
                <td colspan=2 class="fixed">
                      <strong>주문한 상품이 없습니다.</strong>
                </td>
              </tr>
            </c:when>
            <c:otherwise>
                <tr>
                    <td>주문번호:</td><td><a href="${contextPath}/mypage/myOrderDetail.do?order_id=${myOrderList[0].order_id }"><span>${myOrderList[0].order_id }</span></a></td>
                    <td>&nbsp;</td>
                  <td>주문일자:</td><td><span>${myOrderList[0].pay_order_time }</span></td>
                </tr>
             </c:otherwise>
            </c:choose>             
    </table>
    <table class="list_view">
        <tbody align=center>
            <tr style="background: #33ff00">        
                <td>선택</td>        
                <td colspan=2 class="fixed">주문상품명</td>
                <td>수량</td>
                <td>주문금액</td>
                <!--<td>배송비</td>-->
                <!--<td>예상적립금</td>-->
                <!--<td>주문금액합계</td>-->
            </tr>
            <c:forEach var="item" items="${myOrderList }"  varStatus="status">
            <tr>           
                    <td><input type="checkbox" name="goods_id"  checked  value="${item.goods_id }"></td>    <!-- onClick="calcGoodsPrice(${item.goods_sales_price },this)"-->
                    <td class="goods_image">
                      <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
                        <IMG width="75" alt=""  src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
                      </a>
                    </td>
                    <td>
                      <h2>
                         <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
                      </h2>
                    </td>
                    <td>
                      <h2><!--${item.order_goods_qty }개-->
                      <select name="order_goods_qty" onchange="javascript:myListener(this, ${item.goods_sales_price},'ordermoney_${item.goods_id}_${status.count}' );">
                         <c:forEach  var="i" begin="0" end="${item.order_goods_qty - 1 }">
                              <option value="${item.order_goods_qty - i }"  >${item.order_goods_qty - i }</option>
                          </c:forEach>					
                     </select>개<h2>
                    </td>
                    <td><h2 id="ordermoney_${item.goods_id}_${status.count}"><fmt:formatNumber type="number"  pattern="###,###,###,###,###" value="${item.order_goods_qty * item.goods_sales_price}" />원</h2></td>
                    <!--<td><h2>0원</h2></td>-->
                    <!--<td><h2>${1500 *item.order_goods_qty }원</h2></td>-->
                    <!--
                    <td>
                    	<h2 id="savepoint"><fmt:formatNumber type="number"  pattern="###,###,###,###,###" value="${ ((item.order_goods_qty*item.goods_sales_price*0.01*10) - ((item.order_goods_qty*item.goods_sales_price*0.01 *10)%1)) * (1/10)   } " />원</h2></td>-->
                    <!--<td><h2 id="ordermoney2_${item.goods_id}_${status.count}"><fmt:formatNumber type="number"  pattern="###,###,###,###,###" value="${item.order_goods_qty *item.goods_sales_price}" />원</h2></td>-->
            </tr>
            </c:forEach>
    </tbody>
    </table>
    
    
    
    
    <br><br><br>	
  <h1>반품 사유 선택(필수)
        <a href="#"> <img  src="${contextPath}/resources/image/btn_more_see.jpg" />  </a>
</h1>
    <table border=0 width=100%  cellpadding=10 cellspacing=10>
      <tr>
        <td>
          
             <table width="200">
               <tr>
                 <td><strong>1.단순변심</strong></td>
               </tr>
               <tr>
                 <td><label>
                   <input type="radio" name="returnReason" value="10" id="returnReason">
                   필요없어짐</label></td>
               </tr>
               <tr>
                 <td><label>
                   <input type="radio" name="returnReason" value="11" id="returnReason">
                   그외 문제</label></td>
               </tr>
             </table>
             <table width="241">
               <tr>
                 <td><strong>2.상품문제</strong></td>
               </tr>
               <tr>
                 <td><label>
                   <input type="radio" name="returnReason" value="20" id="returnReason">
                   상품의 구성품/부속품이 없음</label></td>
               </tr>
               <tr>
                 <td><label>
                   <input type="radio" name="returnReason" value="21" id="returnReason">
                   상품 설명과 다름</label></td>
               </tr>
               <tr>
                 <td><input type="radio" name="returnReason" value="22" id="returnReason">
    상품이 파손 배송</td>
               </tr>
               <tr>
                 <td><input type="radio" name="returnReason" value="24" id="returnReason">
    상품 결함 또는 기능 이상</td>
               </tr>
             </table>
             <table width="200">
               <tr>
                 <td><strong>3.배송문제</strong></td>
               </tr>
               <tr>
                 <td><label>
                   <input type="radio" name="returnReason" value="30" id="returnReason">
                   다른 상품이 배송</label></td>
               </tr>
             </table>
             <p>&nbsp;</p></td>
       </tr>
       <!--
       <tr>
        <td>수량 :
         <select name="order_goods_qty">
         <c:forEach  var="i" begin="1" end="${myOrderList[0].order_goods_qty}">
              <option value="${i }"  >${i }</option>
          </c:forEach>					
         </select>개  &nbsp;&nbsp;         
                     
         </td>
       </tr>
       -->
    </table>
    
  <table>
    <tr>
<td>
            <c:if test="${message eq 'exchange_req'}">
             <p><input  type="button" onClick="fn_exchange_order('${myOrderList[0].order_id}')" value="교환신청"  /></p>  
           </c:if>
           
           <c:if test="${message eq 'return_req'}">
             <p><input  type="button" onClick="fn_return_order('${myOrderList[0].order_id}')" value="반품신청" /></p>     
           </c:if>   	    	
        </td>
    </tr>
    </table>
    
                
    <br><br><br>	
  <h1>&nbsp;</h1>
</form>
    </body>    
</html>
