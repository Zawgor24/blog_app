# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :password, :name, :age, :avatar

  form do |f|
    f.inputs 'Info' do
      f.input :email
      f.input :password
      f.input :name
      f.input :age
      f.input :avatar
    end
    f.actions
  end
end
