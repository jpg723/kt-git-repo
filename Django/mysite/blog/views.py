from django.utils import timezone
from django.shortcuts import render
from django.http import HttpResponse, Http404
from .models import *
from django.shortcuts import render, get_object_or_404, redirect
from .forms import *
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
    post = get_object_or_404(Post, id=id)
    comment_list = post.comments.all()
    tag_list = post.tag.all()
    
    return render(request, 'blog/detail.html', {'post':post, 'comment_all':comment_list, 'tag_list':tag_list})

def list(request):
    post_list = Post.objects.all()
    
    search_key = request.GET.get('keyword')
    if search_key : 
        post_list = Post.objects.filter(title__contains=search_key)
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

def profile(request):
    user = User.objects.first()
    return render(request, 'blog/profile.html', {'user':user})

def tag_list(request, id):
    tag = Tag.objects.get(id=id)
    post_list = tag.post_set.all()
    return render(request, 'blog/list.html', {'post_all':post_list})

def test7(request):
    print('요청방식:', request.method)
    print('Get방식으로 전달된 QueryString:', request.GET)
    print('Post방식으로 전달된 QueryString:', request.POST)
    print('업로드된 파일:', request.FILES)
    return render(request, 'blog/form_test.html')

# form을 이용한 view객체
def post_create(request):
    if request.method == 'POST' :
        form = PostModelForm(request.POST)
        if form.is_valid():
            print("===>", form.cleaned_data)
            # 입력된 데이터를 db에 저장
            #post = Post.objects.create(**form.cleaned_data)
            
            # ip주소 저장하는 방법(commit지연)
            post = form.save(commit=False) # 기본값이 True
            post.ip = request.META['REMOTE_ADDR']
            post.save()
            
            return redirect(post)
    else:
        form = PostModelForm()
        return render(request, 'blog/post_form.html', {'form':form})

def post_update(request, id):
    post = get_object_or_404(Post, id=id)
    if request.method == 'POST':
        form = PostModelForm(request.POST,  instance=post)
        if form.is_valid():
            form.save()
            return redirect('blog:list')
    else:
        form = PostModelForm(instance=post) # 기존의 데이터를 가져와 보여줘야 함
        return render(request, 'blog/post_update.html', {'form':form})
   
def post_delete(request, id):
     post = get_object_or_404(Post, id=id)
     
     if request.method == 'POST':
         post.delete()
         return redirect('blog:list')
     else:
         return render(request, 'blog/post_delete.html', {'post':post})