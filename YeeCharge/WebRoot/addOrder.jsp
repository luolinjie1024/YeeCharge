<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  </head>
  
  <body>	
	<h1>订单生成</h1>
	<div align="right">
		<a href="/cart.jsp">修改购物车</a>
	</div><hr>
	<form action="/AddOrderServlet" method="post">
		收货地址：<textarea rows="4" cols="40" name="receiverinfo"></textarea><br>
		支付方式：<input type="radio" name="typex" checked="checked"/>在线支付<br>
		<input type="submit" value="生成订单" >
	</form>
	购物清单：<br>
		<table width="100%" style="text-align: center" border="1">
			<tr>
				<th>商品名称</th>
				<th>商品种类</th>
				<th>商品单价</th>
				<th>购买数量</th>
				<th>库存状态</th>
				<th>总价</th>
			</tr>
			<!-- 变量注释：每一个entry代表一条购物信息 ，每一条信息都对应一行记录-->
			<c:set var="money" value="0"/>
			<c:forEach items="${sessionScope.cartmap }" var="entry">
				<tr>
					<td>${entry.key.name}</td>
					<td>${entry.key.category}</td>
					<td>${entry.key.price}元</td>
					<td>${entry.value}件</td>
					<td>
						<!-- 变量注释：entry.value(Integer类型)：用户需要该商品的数量 -->
								<!-- entry.(Product)key.pnum：根据商品bean查到的库存数量 -->
						<c:if test="${entry.value<=entry.key.pnum }">
							<font color="blue">有货</font>
						</c:if>
						<c:if test="${entry.value>entry.key.pnum }">
							<font color="red">缺货</font>
						</c:if>
					</td>
					<td>
						${entry.key.price*entry.value }元
						<c:set var="money" value="${money + entry.key.price*entry.value }"/>
					</td>
				</tr>
			</c:forEach>
		</table>
	<div align="right">
		<font color="red" size=7>总价：${money>0?money:0 }元</font>
	</div>
  </body>
</html>

