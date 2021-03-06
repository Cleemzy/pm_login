const path = require('path');
const glob = require('glob');
const HardSourceWebpackPlugin = require('hard-source-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = (env, options) => {
  const devMode = options.mode !== 'production';

  return {
    optimization: {
      minimizer: [
        new TerserPlugin({ cache: true, parallel: true, sourceMap: devMode }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },
    entry: {
      'app': glob.sync('./vendor/**/*.js').concat(['./js/app.js'])
    },
    output: {
      filename: '[name].js',
      path: path.resolve(__dirname, '../priv/static/js'),
      publicPath: '/js/'
    },
    devtool: devMode ? 'eval-cheap-module-source-map' : undefined,
    module: {
      rules: [
            {
               test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
               include: path.resolve(__dirname, './node_modules/bootstrap-icons/font/fonts'),
               use: {
                   loader: 'file-loader',
                   // options: {
                   //     name: '[name].[ext]',
                   //     outputPath: 'webfonts',
                   //     publicPath: '../webfonts',
                   // },
               }
           },
           {
            test: /\.(esm.js|js|cjs.js)$/i,
            include: path.resolve(__dirname, './node_modules/alpinejs/dist'),
            use: {
                loader: 'file-loader',
            }
        },{
          test: /\.(esm.js|js|cjs.js)$/i,
          include: path.resolve(__dirname, './node_modules/alpinejs/src/directives'),
          use: {
              loader: 'file-loader',
          }
      },

      {
        test: /\.(esm.js|js|cjs.js)$/i,
        include: path.resolve(__dirname, './node_modules/alpinejs/src'),
        use: {
            loader: 'file-loader',
        }
    },

    {
      test: /\.(esm.js|js|cjs.js)$/i,
      include: path.resolve(__dirname, './node_modules/alpinejs/src/magics'),
      use: {
          loader: 'file-loader',
      }
  },

  {
    test: /\.(esm.js|js|cjs.js)$/i,
    include: path.resolve(__dirname, './node_modules/alpinejs/src/utils'),
    use: {
        loader: 'file-loader',
    }
},

{
  test: /\.(esm.js|js|cjs.js)$/i,
  include: path.resolve(__dirname, './node_modules/alpinejs/builds'),
  use: {
      loader: 'file-loader',
  }
},
      
           {
              test: /\.(woff|woff2|eot|otf|css|scss|ttf|png|jpg|gif|svg)$/i,
              include: path.resolve(__dirname, './node_modules/material-icons/iconfont'),
              use: {
                  loader: 'file-loader',
              }
          },

          {
            test: /\.js$/,
            exclude: /node_modules/,
            use: {
              loader: 'babel-loader'
            }
          }, 

        {
          test: /\.[s]?css$/,
          use: [
            MiniCssExtractPlugin.loader,
            'css-loader',
            'sass-loader',
          ],
        }
      ]
    },
    plugins: [
      new MiniCssExtractPlugin({ filename: '../css/app.css' }),
      new CopyWebpackPlugin([{ from: 'static/', to: '../' }])
    ]
    .concat(devMode ? [new HardSourceWebpackPlugin()] : [])
  }
};
