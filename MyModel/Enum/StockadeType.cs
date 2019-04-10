
namespace MyModel.Enum
{
    public enum StockadeType
    {
        /// <summary>
        /// 圈选
        /// </summary>
        Circle = 4,
        /// <summary>
        /// 矩形
        /// </summary>
        Rectangle = 1,
        /// <summary>
        /// 不规则多边形
        /// </summary>
        Polygon = 2,
        /// <summary>
        /// 椭圆形
        /// </summary>
        Oval = 3
    }

    public class StockadeTypeS
    {
        public static string getTpye(int type)
        {
            var temp=string.Empty;
            switch (type)
            {
                case 4:
                    //temp = "圈选";
                    temp = Ryu666.Components.ResourceManager.GetString("Lang_oval");//圆形
                    break;
                case 1:
                    temp = Ryu666.Components.ResourceManager.GetString("Lang_square");//多语言：矩形
                    break;
                case 2:
                    temp = Ryu666.Components.ResourceManager.GetString("Lang_polygon");//多语言：多边形
                    break;
                case 3:
                    temp = Ryu666.Components.ResourceManager.GetString("Lang_ellipse");//多语言：椭圆
                    break;
            }
            return temp;
        }
    }
}
