from django.utils import timezone
from django.shortcuts import render
from django.http import HttpResponse, Http404
from .models import Post
from django.shortcuts import render, get_object_or_404
# ~/blog/test1/ 요청이 들어왔을 때 실행할 View 객체

def test1(request):
    # 서비스 구현
    return HttpResponse('test1!')

def test2(request, id):
    print("no 타입:", type(id))
    return HttpResponse(f'no:{id}')

def test3(request, year, mon, day):
    return HttpResponse(f'{year}년 {mon}월 {day}일')

# def list(request):
#     post_list = Post.objects.all()
#     titles = ''
#     for post in post_list :
#         titles += post.title
        
#     return HttpResponse(titles)

def detail(request, id):
    # try:
    #     post = Post.objects.get(id=id)
    # except:
    #     raise Http404("존재하지 않는 데이터입니다.")
    post = get_object_or_404(Post, id=id)
    
    return render(request, 'blog/detail.html', {'post':post})

def list(request):
    post_list = Post.objects.all()
    return render(request, 'blog/list.html', {'post_all':post_list})
    
def test4(request):
    d1 = timezone.now()
    
    var = """
    The first iteration produces HTML that refers to class row1, 
    the second to row2, the third to row1 again, 
    and so on for each iteration of the loop.

    You can use variables, too. For example,
    if you have two template variables, 
    rowvalue1 and rowvalue2, 
    you can alternate between their values like this:
    """
    return render(request, 'blog/test4.html', {'score':95, 'var':var, 'd1':d1})