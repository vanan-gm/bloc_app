import 'dart:io';

import 'package:bloc_app/core/error/exceptions.dart';
import 'package:bloc_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> updateBlog(BlogModel blogModel);

  Future<String> updateBlogImage(
      {required File image, required BlogModel blogModel});

  Future<List<BlogModel>> getAllBlogs();

  Future<List<BlogModel>> getBlogsByUserId(String userId);
  
  Future<List<BlogModel>> getBlogsByKeyWord(String key);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> updateBlog(BlogModel blogModel) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson())
          .select();
      return BlogModel.fromJson(blogData.first);
    } on StorageException catch(e){
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<String> updateBlogImage(
      {required File image, required BlogModel blogModel}) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blogModel.id, image);
      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blogModel.id);
    } on PostgrestException catch(e){
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (name, image_url)');
      return blogs
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } on PostgrestException catch(e){
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogsByUserId(String userId) async {
    try {
      final blogs =
          await supabaseClient.from('blogs').select('*, profiles (name)').eq("poster_id", userId);
      return blogs
          .map((blog) => BlogModel.fromJson(blog)
          .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } on PostgrestException catch(e){
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogsByKeyWord(String key) async{
    try {
      final blogs =
      await supabaseClient.from('blogs').select('*, profiles (name)').ilike("title", '%$key%');
      return blogs
          .map((blog) => BlogModel.fromJson(blog)
          .copyWith(posterName: blog['profiles']['name']))
          .toList();
    } on PostgrestException catch(e){
      throw ServerException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
