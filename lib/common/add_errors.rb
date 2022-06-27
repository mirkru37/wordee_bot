module Common
  class AddErrors
    include Servicable

    attr_reader :error_store, :obj, :errors

    def initialize(ctx:, error_store:, obj: [], errors: [], **)
      @error_store = error_store
      @obj = Array(obj).map { |key| ctx[key] }
      @errors = Array(errors)
    end

    def call
      add_errors if errors.any?
      merge_object_errors if obj.any?
      error_store.errors.any?
    end

    private

    def add_errors
      errors.each do |attribute, text|
        error_store.add_error(attribute, text)
      end
    end

    def merge_object_errors
      obj.each do |object|
        object.errors.each do |error|
          error_store.add_error(error.attribute, error.message)
        end
      end
    end
  end
end
