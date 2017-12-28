# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :name, :parent_id

  form do |f|
    f.inputs 'Info' do
      f.input :name
      f.input :parent_id, collection: Category.all
    end
    f.actions
  end
end
