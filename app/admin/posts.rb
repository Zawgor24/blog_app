# frozen_string_literal: true

ActiveAdmin.register Post do
  permit_params :title, :body, :category_id, :user_id

  form post: 'Post craeate' do |f|
    f.inputs 'Associations' do
      f.input :category
      f.input :user
    end
    f.inputs 'Details' do
      f.input :title
      f.input :body
    end
    f.actions
  end
end
