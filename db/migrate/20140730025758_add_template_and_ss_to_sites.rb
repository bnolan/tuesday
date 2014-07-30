class AddTemplateAndSsToSites < ActiveRecord::Migration
  def change

        results =<<EOF

      html,body{
        margin: 0;
        padding: 0;
        height: 100%;
      }

      html{
        font-family: 'helvetica neue', 'sans-serif';
        background: white;
        color: #333;
      }

      h1,h2,h3,h4,h5{
        font-weight: 100;
      }

      .main-content{
      }

      body{
        background: #f3f3f3;
      }

      header{
        text-align: center;
      }

      .page-navigation{
        margin: 0;
        padding: 0 0 10px 0;
        text-align: center;
        border-bottom: 1px solid #999;
        border-top: 1px solid #999;

        li{
          display: inline-block;
          margin: 0;
          padding: 0;
          list-style: none;

          a{
            display: inline-block;
            padding: 0 10px;
            color: #555;
          }
        }

        li:after, li:first-child:before{
          content: " | ";
          color: #999;
          font-size: 1.5em;
          position: relative;
          top: 2px;
        }
      }

      *{
        box-sizing: border-box;
      }

      .page-wrapper{
        background: white;
        max-width: 640px;
        min-height: 100%;
        padding: 20px;
        margin: auto;
        box-shadow: 0 0 5px rgba(0,0,0,0.3);
      }

EOF

    Site.update_all :stylesheet => results

    results = <<EOF
      <html>
        <style>@import url(/stylesheet.css)</style>
        <meta name="viewport" content="width=device-width" />
        <title>{{ page.name }} - {{ site.name }}</title>
        <body>
          <div class="page-wrapper">
            <header>
              <h1>
                {{ site.name }}
              </h1>
            </header>

            <ul class="page-navigation">
              {% for page in pages %}
                <li><a href="{{ page.path }}.html">{{ page.name }}</a></li>
              {% endfor %}
            </ul>

            <div class="main-content">
              <p class="breadcrumbs">
                <a href="/">Home</a> &gt; {{ page.name }}</a>
              </p>
              
              <h1 class="page-title">{{ page.title }}</h1>

              {{page.content}}
            </div
          </div>
        </body>
      </html>
EOF

      Site.update_all :template => results

  end
end
