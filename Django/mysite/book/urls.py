from django.urls import path, reverse, reverse_lazy
from django.views.generic import *
from .models import Book

app_name ='book'

urlpatterns = [
    # ListView 제네릭뷰 사용
    # 클래스 뷰를 요청할 때 as_view()함수 사용
    path('', ListView.as_view(model=Book), name='list'),
    # 이미 구현되어 있는 view에 pk로 넘어오도록 설정되어 있음
    path('detail/<pk>', DetailView.as_view(model=Book), name='detail'),
    path('create/', CreateView.as_view(model=Book, fields='__all__'), name='create'),
    path('update/<pk>', UpdateView.as_view(model=Book, fields='__all__'), name='update'),
    path('delete/<pk>/', DeleteView.as_view(model=Book,
success_url=reverse_lazy('book:list')), name='delete'),
]