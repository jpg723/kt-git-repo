from django.contrib.auth.models import User
from rest_framework import serializers
from blog.models import Category, Post, Comment, Tag

class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email', 'is_staff']
        
class PostSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        # fields = '__all__' # 모두출력
        fields = ['id','title','image','like','category'] # 선택 출력


class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'
        
# Router 대신 URL Path 직접 정의하기
class PostListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ['id','title','image','like','category']

class PostRetrieveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        exclude=['create_dt']
        
class PostLikeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Post
        fields = ['like']
        
class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = ['name']

class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ['name']
        
class CateTagSerializer(serializers.Serializer):
    # cateList = CategorySerializer(many=True)
    # tagList = TagSerializer(many=True)
    cateList = serializers.ListField(child=serializers.CharField())
    tagList = serializers.ListField(child=serializers.CharField())
