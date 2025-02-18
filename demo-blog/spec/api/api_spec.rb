# spec/requests/blogs_spec.rb
require 'swagger_helper'

describe 'Blog API' do
  fixtures :users, :posts, :comments # Load users and posts from fixtures

  let(:user) { users(:one) }
  let(:article) { posts(:one) }
  let(:Authorization) { "Bearer #{generate_jwt_token(user)}" }
  path '/api/v1/user/{id}/show_posts' do
    get 'Get all posts for a user' do
      tags 'Posts'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :Authorization, in: :header, type: :string, description: "JWT Token", required: true

      response '200', 'blog found' do
        schema type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer },
            author_id: { type: :integer },
            text: { type: :string }
          },
          required: [ 'id', 'author_id', 'text' ]
        }
        let(:id) { user.id }
        run_test!
      end

      response '404', 'user id not found request' do
        let(:id) { 9999999 }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}/show_comments' do
    get 'Get all comments for a post' do
      tags 'Comments'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :Authorization, in: :header, type: :string, description: "JWT Token", required: true

      response '200', '' do
        schema type: :array,
        items: {
          type: :object,
          properties: {
            id: { type: :integer },
            user_id: { type: :integer },
            post_id: { type: :integer },
            text: { type: :string }
          },
          required: [ 'id', 'user_id', 'post_id', 'text' ]
        }
        let(:id) { article.id }
        run_test!
      end

      response '404', 'post id not found request' do
        let(:id) { 9999999 }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}/create_comment_from_api' do
    post 'Create a comment for a post' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :Authorization, in: :header, type: :string, description: "JWT Token", required: true
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: [ "text" ]
      }

      response '201', 'comment created' do
        let(:id) { article.id }
        let(:comment) { { text: 'comment from test file' } }
        run_test!
      end

      response '404', 'post not found created' do
        let(:id) { 999999 }
        let(:comment) { { text: 'comment from test file' } }
        run_test!
      end
    end
  end
end
