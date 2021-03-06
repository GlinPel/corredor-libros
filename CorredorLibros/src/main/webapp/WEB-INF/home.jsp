<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Formato (fechas) --> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- para errores de renderizado en rutas PUT -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Book list</title>
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
	<script src="/webjars/jquery/jquery.min.js"></script>
	<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<div class="row mt-5">
			<div class="col-6">
				<h4>Hello ${ user.userName }. Welcome to...</h4>
				<h1 class="text-info">The Book Broker!</h1>
			</div>
			<div class="col-6">
				<div class="col-12 d-flex flex-row-reverse">
					<a href="/logout" class="btn btn-primary">Logout</a><br>
				</div>
				<div class="col-12 d-flex flex-row-reverse mt-3">
					<a href="/books/new" class="btn btn-primary">+ Add to my shelf</a>
				</div>
			</div>
		</div>
		<div class="row mt-5">
			<div class="col-12">
				<h4>Available books to borrow</h4>
				<table class="table">
				  <thead>
				    <tr>
				      <th scope="col">ID</th>
				      <th scope="col">Title</th>
				      <th scope="col">Autor Name</th>
				      <th scope="col">Posted By</th>
				      <th scope="col">Actions</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:forEach var="book" items="${noBookBorrowByUser}">
					  	<tr>
					      <th scope="row"><c:out value="${book.id}" /></th>
					      <td>
					      	<a href="/books/${ book.id }"><c:out value="${book.titulo}" /></a>
					      </td>
					      <td><c:out value="${book.author}" /></td>
					      <td><c:out value="${book.user.userName}" /></td>
					      <c:choose>
						    <c:when test="${ book.user.email.equals(user.email)}">
						    	<td class="d-flex">
							    	<a class="btn btn-primary" style="margin-right: 1rem;" href="/books/${book.id}/edit">Edit</a>
							    	<form action="/books/delete" method="POST">
							    		<input type="hidden" name="book_id" value="${book.id}" />
							    		<button class="btn btn-danger" type="submit">Delete</button>
							    	</form>
							    </td>
						    </c:when>    
						    <c:otherwise>
						    	<td>
						    		<form action="/books/addborrow" method="POST">
							    		<input type="hidden" name="book_id" value="${book.id}" />
							    		<button class="btn btn-primary" type="submit">Borrow</button>
							    	</form>
							    </td>
						    </c:otherwise>
						</c:choose>
					      
					    </tr>
				  	</c:forEach>
				  </tbody>
				</table>
			</div>
		</div>
		<div class="row mt-5">
			<div class="col-12">
				<h4>Book I'm borrowing...</h4>
				<table class="table">
				  <thead>
				    <tr>
				      <th scope="col">ID</th>
				      <th scope="col">Title</th>
				      <th scope="col">Autor Name</th>
				      <th scope="col">Posted By</th>
				      <th scope="col">Actions</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:forEach var="book" items="${bookBorrowByUser}">
					  	<tr>
					      <th scope="row"><c:out value="${book.id}" /></th>
					      <td>
					      	<a href="/books/${ book.id }"><c:out value="${book.titulo}" /></a>
					      </td>
					      <td><c:out value="${book.author}" /></td>
					      <td><c:out value="${book.user.userName}" /></td>
					      <td>
					      	<form action="/books/removeborrow" method="POST">
					    		<input type="hidden" name="book_id" value="${book.id}" />
					    		<button class="btn btn-primary" type="submit">Return</button>
					    	</form>
					      </td>
					    </tr>
				  	</c:forEach>
				  </tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>