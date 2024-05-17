from django.shortcuts import render
from django.http import HttpResponse

# ~/blog/test1/ 요청이 들어왔을 때 실행할 View 객체

def test1(request):
    # 서비스 구현
    return HttpResponse('test1!')
