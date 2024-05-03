<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<input type="file" name="files" multiple="multiple"
	onchange="test(this.files)">
<div id="file-list"></div>


<script>
//첨부파일 여러개 올리고 삭제하기 //자바 스크립트 영역
let selectedFiles = []; 
function test(files) {
	const fileList = document.getElementById('file-list');
	for(let i=0; i<files.length; i++) {
	    selectedFiles.push(files[i]);
	    const item=document.createElement( 'div');
	    const fileName=document.createTextNode(files[i].name);
	    const deleteButton=document.createElement('button');
	    deleteButton.addEventListener('click', (event) => {
	    	item.remove();
	    	event.preventDefault();
	    	deleteFile(files[i]);
	    });
		deleteButton.innerText="X";
		item.appendChild(fileName);
		item.appendChild(deleteButton);
		fileList.appendChild(item);
	}
}
function deleteFile(deleteFile) {
	const inputFile = document.querySelector('input[name="files"]');
	const dataTransfer = new DataTransfer();
	selectedFiles = selectedFiles.filter(file => file!==deleteFile);
	selectedFiles.forEach(file => {
		dataTransfer.items.add(file);
	})
	inputFile.files = dataTransfer.files;
}
//=============================== 
</script>