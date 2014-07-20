namespace :convert do
 
  desc "convert a latin1 database with utf8 data into proper utf8"
  task :convert_to_utf8 => :environment do
    puts Time.now
    dryrun = ENV['DOIT'] != '1'
    conn = ActiveRecord::Base.connection
    if dryrun
      def conn.run_sql(sql)
        puts(sql)
      end
    else
      def conn.run_sql(sql)
        puts(sql)
        execute(sql)
      end
    end
 
    database_name = Rails.configuration.database_configuration[ Rails.env ]['database']
 
    conn.run_sql "ALTER DATABASE #{database_name} CHARACTER SET utf8 collate utf8_unicode_ci"
 
    # Don't covert views
    VIEWS = /(view|_v$)/
    big = []
 
    # The following tables will be completely ignored
    ignored_tables = %w[ ]
 
    # The following tables will have their default charset changed,
    # but columns will not be modified, because we don't have an asociated AR model for those tables.
    tables_without_models = %w[
      oauth_access_grants
      oauth_access_tokens
      oauth_applications
 
      schema_migrations
    ]
    # These are table_name => model_class mappings that aren't rails standard
    mapping = {
#       :bla => Blah
    }.with_indifferent_access
 
    tables = (conn.tables - big).select { |tbl| tbl !~ VIEWS }
 
    #(tables - big).each do |tbl|
    tables.each do |tbl|
      next if ignored_tables.include? tbl
 
      a = ['CHARACTER SET utf8 COLLATE utf8_unicode_ci']
      b = []
      unless tables_without_models.include? tbl
        model = mapping[tbl] || tbl.to_s.classify.constantize
 
        model.columns.each do |col|
          type = col.sql_type
 
          nullable = col.null ? '' : ' NOT NULL'
          default = col.default ? " DEFAULT '#{col.default}'" : ''
 
          case type
          when /varchar/
            a << "CHANGE #{conn.quote_column_name(col.name)} #{conn.quote_column_name(col.name)} VARBINARY(#{col.limit})"
            b << "CHANGE #{conn.quote_column_name(col.name)} #{conn.quote_column_name(col.name)} VARCHAR(#{col.limit}) CHARACTER SET utf8 COLLATE utf8_unicode_ci#{nullable}#{default}"
          when /text/
            a << "CHANGE #{conn.quote_column_name(col.name)} #{conn.quote_column_name(col.name)} BLOB"
            b << "CHANGE #{conn.quote_column_name(col.name)} #{conn.quote_column_name(col.name)} TEXT CHARACTER SET utf8 COLLATE utf8_unicode_ci#{nullable}#{default}"
          end
        end
      end
 
      conn.run_sql "ALTER TABLE #{tbl} #{a.join(', ')}"
      conn.run_sql "ALTER TABLE #{tbl} #{b.join(', ')}" if b.present?
    end
 
    puts Time.now
    puts 'Done!'
  end
 
end