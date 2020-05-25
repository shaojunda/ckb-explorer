require "test_helper"

module Api
  module V1
    class MonetaryDataControllerTest < ActionDispatch::IntegrationTest
      setup do
        MonetaryData.any_instance.stubs(:id).returns(1)
      end

      test "should set right content type when call show" do
        valid_get api_v1_monetary_datum_url("nominal_apc")

        assert_equal "application/vnd.api+json", response.media_type
      end

      test "should respond with 415 Unsupported Media Type when Content-Type is wrong" do
        get api_v1_monetary_datum_url("nominal_apc"), headers: { "Content-Type": "text/plain" }

        assert_equal 415, response.status
      end

      test "should respond with error object when Content-Type is wrong" do
        error_object = Api::V1::Exceptions::InvalidContentTypeError.new
        response_json = RequestErrorSerializer.new([error_object], message: error_object.title).serialized_json

        get api_v1_monetary_datum_url("nominal_apc"), headers: { "Content-Type": "text/plain" }

        assert_equal response_json, response.body
      end

      test "should respond with 406 Not Acceptable when Accept is wrong" do
        get api_v1_monetary_datum_url("nominal_apc"), headers: { "Content-Type": "application/vnd.api+json", "Accept": "application/json" }

        assert_equal 406, response.status
      end

      test "should respond with error object when Accept is wrong" do
        error_object = Api::V1::Exceptions::InvalidAcceptError.new
        response_json = RequestErrorSerializer.new([error_object], message: error_object.title).serialized_json

        get api_v1_monetary_datum_url("nominal_apc"), headers: { "Content-Type": "application/vnd.api+json", "Accept": "application/json" }

        assert_equal response_json, response.body
      end

      test "should return correct nominal apc" do
        expected_nominal_apc = [4.0, 3.94574599, 3.89294403, 3.84153661, 3.79146919, 3.74269005, 3.69515011, 3.64880273, 3.6036036, 3.55951056, 3.51648351, 3.47448425, 3.43347639, 3.39342523, 3.35429769, 3.31606217, 3.27868852, 3.24214792, 3.20641282, 3.17145688, 3.1372549, 3.10378273, 3.07101727, 3.03893637, 3.00751879, 2.97674418, 2.946593, 2.91704649, 2.88808664, 2.85969615, 2.8318584, 2.8045574, 2.77777777, 2.75150472, 2.72572402, 2.70042194, 2.67558528, 2.65120132, 2.62725779, 2.60374288, 2.58064516, 2.55795363, 2.53565768, 2.51374705, 2.49221183, 2.47104247, 2.4502297, 2.42976461, 2.41722271, 2.40480961, 2.39252336, 2.38036201, 2.36832367, 2.35640648, 2.34460862, 2.33292831, 2.3213638, 2.30991337, 2.29857536, 2.2873481, 2.27622999, 2.26521944, 2.25431489, 2.24351483, 2.23281776, 2.22222222, 2.21172675, 2.20132997, 2.19103046, 2.18082689, 2.17071791, 2.16070222, 2.15077853, 2.14094558, 2.13120213, 2.12154696, 2.11197888, 2.10249671, 2.09309931, 2.08378554, 2.07455429, 2.06540447, 2.05633501, 2.04734484, 2.03843295, 2.0295983, 2.02083991, 2.01215678, 2.00354794, 1.99501246, 1.9865494, 1.97815784, 1.96983687, 1.96158561, 1.95340319, 1.94528875, 1.93968783, 1.93411906, 1.92858219, 1.92307692, 1.91760299, 1.91216014, 1.9067481, 1.9013666, 1.8960154, 1.89069423, 1.88540285, 1.88014101, 1.87490845, 1.86970493, 1.86453022, 1.85938407, 1.85426626, 1.84917653, 1.84411468, 1.83908045, 1.83407364, 1.82909402, 1.82414137, 1.81921546, 1.81431608, 1.80944303, 1.80459608, 1.79977502, 1.79497966, 1.79020979, 1.78546519, 1.78074568, 1.77605106, 1.77138112, 1.76673567, 1.76211453, 1.7575175, 1.75294439, 1.74839502, 1.7438692, 1.73936676, 1.7348875, 1.73043125, 1.72599784, 1.72158708, 1.71719881, 1.71283286, 1.70848905, 1.70511311, 1.70175049, 1.69840111, 1.69506488, 1.69174174, 1.6884316, 1.68513439, 1.68185003, 1.67857845, 1.67531957, 1.67207332, 1.66883963, 1.66561842, 1.66240962, 1.65921317, 1.65602898, 1.65285698, 1.64969712, 1.64654932, 1.6434135, 1.64028961, 1.63717757, 1.63407732, 1.63098878, 1.6279119, 1.62484661, 1.62179284, 1.61875052, 1.6157196, 1.61270001, 1.60969168, 1.60669456, 1.60370857, 1.60073366, 1.59776977, 1.59481684, 1.5918748, 1.5889436, 1.58602317, 1.58311345, 1.58021439, 1.57732593, 1.57444802, 1.57158058, 1.56872357, 1.56587693, 1.5630406, 1.56021452, 1.55779353, 1.55538003, 1.552974, 1.5505754, 1.5481842, 1.54580037, 1.54342386, 1.54105465, 1.53869271, 1.53633799, 1.53399047, 1.53165011, 1.52931688, 1.52699075, 1.52467168, 1.52235965, 1.52005462, 1.51775656, 1.51546544, 1.51318122, 1.51090388, 1.50863339, 1.5063697, 1.5041128, 1.50186266, 1.49961923, 1.4973825, 1.49515243, 1.49292899, 1.49071216, 1.4885019, 1.48629818, 1.48410098, 1.48191027, 1.47972601, 1.47754819, 1.47537676, 1.47321171, 1.471053, 1.46890061, 1.46675451, 1.46461468, 1.46248107, 1.46035367, 1.45823246, 1.45611739, 1.45400846, 1.45190562].map(&:to_s)

        valid_get api_v1_monetary_datum_url("nominal_apc")

        assert_equal expected_nominal_apc, json.dig("data", "attributes", "nominal_apc")
      end

      test "should return correct inflation_rate" do
        expected_nominal_apc = [4.0, 3.94574599, 3.89294403, 3.84153661, 3.79146919, 3.74269005, 3.69515011, 3.64880273, 3.6036036, 3.55951056, 3.51648351, 3.47448425, 3.43347639, 3.39342523, 3.35429769, 3.31606217, 3.27868852, 3.24214792, 3.20641282, 3.17145688, 3.1372549, 3.10378273, 3.07101727, 3.03893637, 3.00751879, 2.97674418, 2.946593, 2.91704649, 2.88808664, 2.85969615, 2.8318584, 2.8045574, 2.77777777, 2.75150472, 2.72572402, 2.70042194, 2.67558528, 2.65120132, 2.62725779, 2.60374288, 2.58064516, 2.55795363, 2.53565768, 2.51374705, 2.49221183, 2.47104247, 2.4502297, 2.42976461, 2.41722271, 2.40480961, 2.39252336, 2.38036201, 2.36832367, 2.35640648, 2.34460862, 2.33292831, 2.3213638, 2.30991337, 2.29857536, 2.2873481, 2.27622999, 2.26521944, 2.25431489, 2.24351483, 2.23281776, 2.22222222, 2.21172675, 2.20132997, 2.19103046, 2.18082689, 2.17071791, 2.16070222, 2.15077853, 2.14094558, 2.13120213, 2.12154696, 2.11197888, 2.10249671, 2.09309931, 2.08378554, 2.07455429, 2.06540447, 2.05633501, 2.04734484, 2.03843295, 2.0295983, 2.02083991, 2.01215678, 2.00354794, 1.99501246, 1.9865494, 1.97815784, 1.96983687, 1.96158561, 1.95340319, 1.94528875, 1.93968783, 1.93411906, 1.92858219, 1.92307692, 1.91760299, 1.91216014, 1.9067481, 1.9013666, 1.8960154, 1.89069423, 1.88540285, 1.88014101, 1.87490845, 1.86970493, 1.86453022, 1.85938407, 1.85426626, 1.84917653, 1.84411468, 1.83908045, 1.83407364, 1.82909402, 1.82414137, 1.81921546, 1.81431608, 1.80944303, 1.80459608, 1.79977502, 1.79497966, 1.79020979, 1.78546519, 1.78074568, 1.77605106, 1.77138112, 1.76673567, 1.76211453, 1.7575175, 1.75294439, 1.74839502, 1.7438692, 1.73936676, 1.7348875, 1.73043125, 1.72599784, 1.72158708, 1.71719881, 1.71283286, 1.70848905, 1.70511311, 1.70175049, 1.69840111, 1.69506488, 1.69174174, 1.6884316, 1.68513439, 1.68185003, 1.67857845, 1.67531957, 1.67207332, 1.66883963, 1.66561842, 1.66240962, 1.65921317, 1.65602898, 1.65285698, 1.64969712, 1.64654932, 1.6434135, 1.64028961, 1.63717757, 1.63407732, 1.63098878, 1.6279119, 1.62484661, 1.62179284, 1.61875052, 1.6157196, 1.61270001, 1.60969168, 1.60669456, 1.60370857, 1.60073366, 1.59776977, 1.59481684, 1.5918748, 1.5889436, 1.58602317, 1.58311345, 1.58021439, 1.57732593, 1.57444802, 1.57158058, 1.56872357, 1.56587693, 1.5630406, 1.56021452, 1.55779353, 1.55538003, 1.552974, 1.5505754, 1.5481842, 1.54580037, 1.54342386, 1.54105465, 1.53869271, 1.53633799, 1.53399047, 1.53165011, 1.52931688, 1.52699075, 1.52467168, 1.52235965, 1.52005462, 1.51775656, 1.51546544, 1.51318122, 1.51090388, 1.50863339, 1.5063697, 1.5041128, 1.50186266, 1.49961923, 1.4973825, 1.49515243, 1.49292899, 1.49071216, 1.4885019, 1.48629818, 1.48410098, 1.48191027, 1.47972601, 1.47754819, 1.47537676, 1.47321171, 1.471053, 1.46890061, 1.46675451, 1.46461468, 1.46248107, 1.46035367, 1.45823246, 1.45611739, 1.45400846, 1.45190562, 1.44997994, 1.44805935, 1.44614385, 1.4442334, 1.442328, 1.44042762, 1.43853224, 1.43664184, 1.43475641, 1.43287592, 1.43100034, 1.42912968, 1.42726389, 1.42540298, 1.42354691, 1.42169566, 1.41984923, 1.41800758, 1.41617071, 1.41433859, 1.4125112, 1.41068853, 1.40887056, 1.40705727, 1.40524864, 1.40344465, 1.40164529, 1.39985053, 1.39806037, 1.39627478, 1.39449374, 1.39271724, 1.39094527, 1.38917779, 1.38741481, 1.38565629, 1.38390222, 1.38215259, 1.38040738, 1.37866657, 1.37693014, 1.37519808, 1.37347038, 1.37174701, 1.37002796, 1.36831321, 1.36660275, 1.36489656, 1.36327025, 1.3616478, 1.36002921, 1.35841447, 1.35680356, 1.35519646, 1.35359316, 1.35199366, 1.35039793, 1.34880596, 1.34721774, 1.34563326, 1.3440525, 1.34247545, 1.34090209, 1.33933242, 1.33776642, 1.33620408, 1.33464538, 1.33309032, 1.33153887, 1.32999103, 1.32844679, 1.32690613, 1.32536903, 1.3238355, 1.32230551, 1.32077905, 1.31925611, 1.31773668, 1.31622074, 1.31470829, 1.31319932, 1.3116938, 1.31019173, 1.30869309, 1.30719788, 1.30570608, 1.30421769, 1.30273268, 1.30125105, 1.29977279, 1.29829788, 1.29682632, 1.29535808, 1.29389317, 1.29243157, 1.29097327, 1.28955208, 1.28813402, 1.28671908, 1.28530724, 1.2838985, 1.28249284, 1.28109026, 1.27969074, 1.27829427, 1.27690085, 1.27551046, 1.2741231, 1.27273876, 1.27135741, 1.26997907, 1.26860371, 1.26723132, 1.2658619, 1.26449544, 1.26313192, 1.26177134, 1.26041369, 1.25905896, 1.25770714, 1.25635821, 1.25501218, 1.25366903, 1.25232875, 1.25099133, 1.24965677, 1.24832505, 1.24699616, 1.24567011, 1.24434686, 1.24302643, 1.2417088, 1.24039396, 1.2390819, 1.23777261, 1.23646608, 1.23516232, 1.23386129, 1.23256301, 1.23126745, 1.22997462, 1.2286845, 1.22739708, 1.22611236, 1.22484558, 1.22358142, 1.22231987, 1.22106091, 1.21980455, 1.21855076, 1.21729956, 1.21605092, 1.21480484, 1.21356131, 1.21232032, 1.21108187, 1.20984594, 1.20861254, 1.20738165, 1.20615326, 1.20492737, 1.20370397, 1.20248305, 1.20126461, 1.20004863, 1.19883511, 1.19762404, 1.19641542, 1.19520924, 1.19400548, 1.19280415, 1.19160523, 1.19040872, 1.18921461, 1.18802289, 1.18683356, 1.18564661, 1.18446203, 1.18327981, 1.18209995, 1.18092245, 1.17974728, 1.17857446, 1.17740396, 1.17623578, 1.17506992, 1.17390637, 1.17274512, 1.17158617, 1.1704295, 1.16927512, 1.16812301, 1.1669801, 1.16583942, 1.16470097, 1.16356474, 1.16243072, 1.16129891, 1.16016931, 1.1590419, 1.15791668, 1.15679364, 1.15567278, 1.15455409, 1.15343756, 1.15232319, 1.15121097, 1.15010089, 1.14899295, 1.14788715, 1.14678347, 1.14568192, 1.14458247, 1.14348514, 1.14238991, 1.14129677, 1.14020572, 1.13911676, 1.13802988, 1.13694507, 1.13586232, 1.13478163, 1.133703, 1.13262642, 1.13155188, 1.13047938, 1.12940891, 1.12834046, 1.12727403, 1.12620962, 1.12514721, 1.12408681, 1.12302841, 1.12197199, 1.12091756, 1.11986512, 1.11881464, 1.11776614, 1.11671959, 1.11567501, 1.11463554, 1.113598, 1.1125624, 1.11152871, 1.11049695, 1.1094671, 1.10843916, 1.10741312, 1.10638898, 1.10536673, 1.10434637, 1.10332789, 1.10231129, 1.10129656, 1.1002837, 1.09927269, 1.09826355, 1.09725625, 1.0962508, 1.09524719, 1.09424542, 1.09324548, 1.09224737, 1.09125107, 1.09025659, 1.08926392, 1.08827306, 1.087284, 1.08629674, 1.08531126, 1.08432758, 1.08334567, 1.08236554, 1.08138719, 1.0804106, 1.07943577, 1.0784627, 1.07749138, 1.07652181, 1.07555399, 1.0745879, 1.07362355, 1.07266092, 1.07170002, 1.07074084, 1.06978338, 1.06882763, 1.06787358, 1.06692268, 1.06597348, 1.06502596, 1.06408012, 1.06313597, 1.06219349, 1.06125267, 1.06031352, 1.05937604, 1.05844021, 1.05750603, 1.0565735, 1.05564261, 1.05471336, 1.05378574, 1.05285976, 1.0519354, 1.05101266, 1.05009154, 1.04917204, 1.04825414, 1.04733785, 1.04642315, 1.04551006, 1.04459855, 1.04368864, 1.04278031, 1.04187355, 1.04096838, 1.04006477, 1.03916273, 1.03826226, 1.03736334, 1.03646598, 1.03557017, 1.03467591, 1.03378319, 1.03289201, 1.03200237, 1.03111425, 1.03022767, 1.0293426, 1.02845906, 1.02757703, 1.02669652, 1.02581751, 1.02494, 1.024064, 1.02319016, 1.0223178, 1.02144694, 1.02057755, 1.01970965, 1.01884322, 1.01797826, 1.01711476, 1.01625274, 1.01539217, 1.01453305, 1.01367539, 1.01281918, 1.01196442, 1.01111109, 1.01025921, 1.00940875, 1.00855973, 1.00771214, 1.00686597, 1.00602122, 1.00517788, 1.00433596, 1.00349545].map(&:to_s)
        expected_nominal_inflation_rate = [16.5, 16.27620221, 16.05839416, 15.84633853, 15.63981042, 15.43859649, 15.24249422, 15.05131128, 14.86486486, 14.68298109, 14.5054945, 14.33224755, 14.16309012, 13.9978791, 13.83647798, 13.67875647, 13.52459016, 13.37386018, 13.2264529, 13.08225966, 12.94117647, 12.80310378, 12.66794625, 12.53561253, 12.40601503, 12.27906976, 12.15469613, 12.03281677, 11.9133574, 11.79624664, 11.68141592, 11.56879929, 11.45833333, 11.349957, 11.24361158, 11.1392405, 11.03678929, 10.93620546, 10.83743842, 10.74043938, 10.64516129, 10.55155875, 10.45958795, 10.36920659, 10.28037383, 10.19305019, 10.10719754, 10.02277904, 6.19413319, 6.16232464, 6.13084112, 6.09967765, 6.0688294, 6.0382916, 6.00805959, 5.97812879, 5.94849474, 5.91915303, 5.89009936, 5.86132952, 5.83283935, 5.80462482, 5.77668193, 5.74900677, 5.72159553, 5.69444444, 5.66754982, 5.64090804, 5.61451557, 5.58836892, 5.56246466, 5.53679945, 5.51137, 5.48617305, 5.46120546, 5.43646408, 5.41194588, 5.38764783, 5.36356699, 5.33970045, 5.31604538, 5.29259896, 5.26935846, 5.24632117, 5.22348444, 5.20084566, 5.17840227, 5.15615175, 5.13409162, 5.11221945, 5.09053285, 5.06902946, 5.04770698, 5.02656313, 5.00559568, 4.98480243, 3.45506894, 3.44514959, 3.43528702, 3.42548076, 3.41573033, 3.40603525, 3.39639505, 3.38680926, 3.37727744, 3.36779911, 3.35837384, 3.34900117, 3.33968067, 3.33041191, 3.32119446, 3.31202789, 3.30291177, 3.2938457, 3.28482927, 3.27586206, 3.26694368, 3.25807373, 3.24925181, 3.24047754, 3.23175053, 3.22307039, 3.21443676, 3.20584926, 3.19730753, 3.18881118, 3.18035988, 3.17195325, 3.16359095, 3.15527262, 3.14699792, 3.13876651, 3.13057805, 3.12243221, 3.11432864, 3.10626702, 3.09824704, 3.09026836, 3.08233067, 3.07443365, 3.066577, 3.05876039, 3.05098354, 3.04324612, 2.37117293, 2.36649678, 2.36183904, 2.35719961, 2.35257836, 2.3479752, 2.34339001, 2.3388227, 2.33427316, 2.32974128, 2.32522697, 2.32073011, 2.31625062, 2.31178838, 2.30734331, 2.3029153, 2.29850425, 2.29411006, 2.28973265, 2.2853719, 2.28102774, 2.27670006, 2.27238877, 2.26809378, 2.26381499, 2.25955232, 2.25530566, 2.25107495, 2.24686007, 2.24266095, 2.23847749, 2.23430962, 2.23015723, 2.22602025, 2.22189859, 2.21779217, 2.2137009, 2.20962469, 2.20556347, 2.20151715, 2.19748564, 2.19346888, 2.18946677, 2.18547925, 2.18150621, 2.1775476, 2.17360333, 2.16967333, 1.86205008, 1.85916519, 1.85628924, 1.85342216, 1.85056393, 1.8477145, 1.84487384, 1.84204189, 1.83921863, 1.836404, 1.83359798, 1.83080052, 1.82801158, 1.82523113, 1.82245912, 1.81969552, 1.81694029, 1.81419339, 1.81145478, 1.80872443, 1.8060023, 1.80328834, 1.80058254, 1.79788484, 1.79519521, 1.79251361, 1.78984002, 1.78717439, 1.78451669, 1.78186688, 1.77922493, 1.7765908, 1.77396446, 1.77134587, 1.768735, 1.76613182, 1.76353629, 1.76094838, 1.75836805, 1.75579527, 1.75323001, 1.75067223, 1.74812191, 1.745579, 1.74304349, 1.74051532, 1.73799449, 1.73548094, 1.59157954, 1.5894714, 1.58736883, 1.58527182, 1.58318035, 1.58109438, 1.57901391, 1.5769389, 1.57486934, 1.5728052, 1.57074647, 1.56869312, 1.56664514, 1.56460249, 1.56256516, 1.56053313, 1.55850638, 1.55648489, 1.55446863, 1.55245759, 1.55045175, 1.54845108, 1.54645558, 1.5444652, 1.54247995, 1.54049979, 1.53852471, 1.53655469, 1.5345897, 1.53262974, 1.53067477, 1.52872479, 1.52677977, 1.52483969, 1.52290453, 1.52097428, 1.51904892, 1.51712843, 1.51521279, 1.51330197, 1.51139597, 1.50949477, 1.50759834, 1.50570668, 1.50381975, 1.50193755, 1.50006005, 1.49818724, 1.42983618, 1.42813451, 1.42643689, 1.4247433, 1.42305373, 1.42136816, 1.41968658, 1.41800897, 1.41633533, 1.41466563, 1.41299986, 1.41133801, 1.40968006, 1.40802601, 1.40637583, 1.40472951, 1.40308705, 1.40144842, 1.39981361, 1.39818262, 1.39655542, 1.394932, 1.39331236, 1.39169647, 1.39008432, 1.3884759, 1.38687121, 1.38527021, 1.38367291, 1.38207929, 1.38048934, 1.37890304, 1.37732038, 1.37574135, 1.37416593, 1.37259412, 1.3710259, 1.36946126, 1.36790019, 1.36634267, 1.3647887, 1.36323826, 1.36169133, 1.36014791, 1.35860799, 1.35707155, 1.35553858, 1.35400907, 1.32103529, 1.31958261, 1.31813312, 1.31668681, 1.31524368, 1.3138037, 1.31236687, 1.31093319, 1.30950263, 1.30807519, 1.30665086, 1.30522962, 1.30381148, 1.30239641, 1.30098441, 1.29957548, 1.29816958, 1.29676673, 1.29536691, 1.2939701, 1.29257631, 1.29118551, 1.2897977, 1.28841288, 1.28703102, 1.28565213, 1.28427618, 1.28290318, 1.28153311, 1.28016597, 1.27880173, 1.27744041, 1.27608197, 1.27472643, 1.27337376, 1.27202396, 1.27067701, 1.26933292, 1.26799167, 1.26665325, 1.26531765, 1.26398486, 1.26265488, 1.2613277, 1.2600033, 1.25868168, 1.25736283, 1.25604674, 1.23979731, 1.23851772, 1.23724076, 1.23596644, 1.23469474, 1.23342565, 1.23215917, 1.23089529, 1.229634, 1.22837529, 1.22711915, 1.22586558, 1.22461457, 1.22336611, 1.22212019, 1.22087681, 1.21963596, 1.21839762, 1.2171618, 1.21592848, 1.21469766, 1.21346933, 1.21224348, 1.2110201, 1.20979919, 1.20858074, 1.20736475, 1.20615119, 1.20494007, 1.20373139, 1.20252512, 1.20132127, 1.20011983, 1.19892079, 1.19772415, 1.19652989, 1.195338, 1.19414849, 1.19296135, 1.19177656, 1.19059413, 1.18941404, 1.18823628, 1.18706086, 1.18588776, 1.18471697, 1.1835485, 1.18238233, 1.17410278, 1.17295514, 1.17180974, 1.17066657, 1.16952564, 1.16838692, 1.16725042, 1.16611613, 1.16498404, 1.16385415, 1.16272644, 1.16160092, 1.16047758, 1.15935641, 1.1582374, 1.15712055, 1.15600585, 1.1548933, 1.15378288, 1.1526746, 1.15156845, 1.15046442, 1.1493625, 1.14826269, 1.14716499, 1.14606938, 1.14497586, 1.14388443, 1.14279507, 1.14170779, 1.14062258, 1.13953942, 1.13845832, 1.13737928, 1.13630227, 1.1352273, 1.13415437, 1.13308346, 1.13201457, 1.13094769, 1.12988283, 1.12881997, 1.1277591, 1.12670023, 1.12564334, 1.12458844, 1.12353551, 1.12248455, 1.11803714, 1.11699643, 1.11595767, 1.11492083, 1.11388592, 1.11285292, 1.11182185, 1.11079268, 1.10976541, 1.10874004, 1.10771657, 1.10669498, 1.10567528, 1.10465745, 1.10364149, 1.10262741, 1.10161518, 1.10060481, 1.09959629, 1.09858962, 1.09758479, 1.0965818, 1.09558064, 1.0945813, 1.09358379, 1.09258809, 1.09159421, 1.09060213, 1.08961185, 1.08862337, 1.08763668, 1.08665178, 1.08566866, 1.08468732, 1.08370775, 1.08272994, 1.08175391, 1.08077962, 1.0798071, 1.07883632, 1.07786728, 1.07689999, 1.07593442, 1.07497059, 1.07400849, 1.0730481, 1.07208943, 1.07113247, 1.06855068, 1.06760002, 1.06665106, 1.06570378, 1.06475818, 1.06381426, 1.06287202, 1.06193143, 1.06099252, 1.06005526, 1.05911965, 1.0581857, 1.05725339, 1.05632272, 1.05539369, 1.0544663, 1.05354053, 1.05261638, 1.05169386, 1.05077295, 1.04985365, 1.04893596, 1.04801987, 1.04710538, 1.04619248, 1.04528118, 1.04437146, 1.04346333, 1.04255677, 1.04165178, 1.04074837, 1.03984652, 1.03894623, 1.0380475, 1.03715033, 1.0362547, 1.03536062, 1.03446808, 1.03357708, 1.03268761, 1.03179967, 1.03091326, 1.03002837, 1.02914499, 1.02826313, 1.02738278, 1.02650394, 1.0256266, 1.02397079, 1.02309777, 1.02222624, 1.02135619, 1.02048762, 1.01962053, 1.01875491, 1.01789076, 1.01702807, 1.01616685, 1.01530708, 1.01444877, 1.0135919, 1.01273649, 1.01188251, 1.01102997, 1.01017887, 1.0093292, 1.00848096, 1.00763415, 1.00678875, 1.00594477, 1.00510221, 1.00426105].map(&:to_s)
        expected_real_inflation_rate = [12.5, 12.33045622, 12.16545012, 12.00480192, 11.84834123, 11.69590644, 11.54734411, 11.40250855, 11.26126126, 11.12347053, 10.98901099, 10.8577633, 10.72961373, 10.60445387, 10.48218028, 10.36269429, 10.24590164, 10.13171226, 10.02004007, 9.91080278, 9.80392157, 9.69932105, 9.59692898, 9.49667616, 9.39849624, 9.30232558, 9.20810313, 9.11577028, 9.02527076, 8.93655049, 8.84955751, 8.76424188, 8.68055556, 8.59845228, 8.51788756, 8.43881856, 8.36120401, 8.28500414, 8.21018063, 8.13669649, 8.06451613, 7.99360512, 7.92393027, 7.85545953, 7.788162, 7.72200771, 7.65696784, 7.59301443, 3.77691048, 3.75751502, 3.73831776, 3.71931564, 3.70050573, 3.68188512, 3.66345097, 3.64520048, 3.62713094, 3.60923966, 3.591524, 3.57398142, 3.55660936, 3.53940538, 3.52236704, 3.50549194, 3.48877777, 3.47222222, 3.45582306, 3.43957807, 3.42348511, 3.40754202, 3.39174675, 3.37609723, 3.36059147, 3.34522747, 3.33000333, 3.31491712, 3.299967, 3.28515111, 3.27046768, 3.2559149, 3.24149109, 3.22719449, 3.21302345, 3.19897633, 3.18505149, 3.17124736, 3.15756236, 3.14399497, 3.13054368, 3.11720699, 3.10398345, 3.09087162, 3.07787011, 3.06497752, 3.05219249, 3.03951368, 1.51538111, 1.51103053, 1.50670483, 1.50240384, 1.49812734, 1.49387511, 1.48964695, 1.48544266, 1.48126203, 1.47710488, 1.47297099, 1.46886016, 1.46477222, 1.46070698, 1.45666424, 1.45264382, 1.44864551, 1.44466916, 1.44071459, 1.43678161, 1.43287003, 1.42897971, 1.42511044, 1.42126208, 1.41743444, 1.41362736, 1.40984067, 1.40607424, 1.40232786, 1.39860139, 1.39489469, 1.39120757, 1.38753989, 1.38389149, 1.38026225, 1.37665198, 1.37306055, 1.36948782, 1.36593362, 1.36239782, 1.35888028, 1.35538086, 1.35189942, 1.34843581, 1.34498992, 1.34156158, 1.33815067, 1.33475707, 0.66605982, 0.66474628, 0.66343792, 0.66213472, 0.66083661, 0.6595436, 0.65825561, 0.65697267, 0.6556947, 0.6544217, 0.65315365, 0.65189048, 0.6506322, 0.64937875, 0.64813013, 0.64688631, 0.64564727, 0.64441294, 0.64318332, 0.64195839, 0.64073812, 0.63952249, 0.63831145, 0.637105, 0.63590309, 0.63470571, 0.63351282, 0.63232442, 0.63114046, 0.62996093, 0.62878581, 0.62761505, 0.62644866, 0.62528659, 0.62412881, 0.62297533, 0.6218261, 0.62068109, 0.61954029, 0.6184037, 0.61727124, 0.61614295, 0.61501875, 0.61389867, 0.61278263, 0.61167067, 0.61056273, 0.60945881, 0.30425654, 0.30378515, 0.30331523, 0.30284676, 0.30237973, 0.30191412, 0.30144997, 0.30098724, 0.30052591, 0.300066, 0.2996075, 0.2991504, 0.29869469, 0.29824037, 0.29778744, 0.29733586, 0.29688567, 0.29643683, 0.29598934, 0.2955432, 0.29509841, 0.29465494, 0.29421283, 0.29377204, 0.29333254, 0.29289438, 0.29245751, 0.29202195, 0.2915877, 0.29115471, 0.29072303, 0.29029262, 0.28986347, 0.2894356, 0.28900898, 0.28858362, 0.28815952, 0.28773667, 0.28731505, 0.28689465, 0.2864755, 0.28605755, 0.28564084, 0.28522533, 0.28481102, 0.28439793, 0.28398602, 0.28357531, 0.14159959, 0.14141205, 0.14122498, 0.14103842, 0.14085234, 0.14066676, 0.14048167, 0.14029705, 0.14011292, 0.13992927, 0.13974613, 0.13956344, 0.13938125, 0.1391995, 0.13901824, 0.13883747, 0.13865715, 0.1384773, 0.13829791, 0.13811899, 0.13794054, 0.13776254, 0.13758501, 0.13740793, 0.13723131, 0.13705513, 0.13687941, 0.13670416, 0.13652932, 0.13635496, 0.13618103, 0.13600754, 0.1358345, 0.1356619, 0.13548971, 0.13531798, 0.13514669, 0.13497584, 0.13480541, 0.1346354, 0.13446582, 0.13429669, 0.13412795, 0.13395967, 0.13379178, 0.13362434, 0.1334573, 0.13329068, 0.06656592, 0.0664867, 0.06640767, 0.06632883, 0.06625017, 0.0661717, 0.06609342, 0.06601531, 0.06593739, 0.06585967, 0.06578211, 0.06570474, 0.06562755, 0.06555055, 0.06547374, 0.06539708, 0.06532062, 0.06524434, 0.06516823, 0.0650923, 0.06501655, 0.06494097, 0.06486556, 0.06479034, 0.06471528, 0.0646404, 0.06456569, 0.06449115, 0.0644168, 0.0643426, 0.0642686, 0.06419474, 0.06412105, 0.06404754, 0.06397419, 0.06390103, 0.06382802, 0.06375518, 0.0636825, 0.06360999, 0.06353765, 0.06346546, 0.06339344, 0.06332158, 0.06324991, 0.06317837, 0.063107, 0.06303579, 0.0314832, 0.03144859, 0.03141404, 0.03137956, 0.03134517, 0.03131086, 0.0312766, 0.03124245, 0.03120835, 0.03117433, 0.03114039, 0.03110652, 0.03107272, 0.031039, 0.03100534, 0.03097176, 0.03093825, 0.03090483, 0.03087147, 0.03083817, 0.03080497, 0.03077182, 0.03073874, 0.03070574, 0.0306728, 0.03063994, 0.03060715, 0.03057442, 0.03054178, 0.0305092, 0.03047668, 0.03044425, 0.03041185, 0.03037957, 0.03034732, 0.03031516, 0.03028304, 0.03025102, 0.03021906, 0.03018717, 0.03015533, 0.03012356, 0.03009186, 0.03006025, 0.03002868, 0.02999718, 0.02996574, 0.02993438, 0.01495172, 0.0149363, 0.01492088, 0.01490553, 0.01489018, 0.01487488, 0.01485961, 0.01484437, 0.01482915, 0.01481398, 0.01479883, 0.01478371, 0.01476863, 0.01475356, 0.01473853, 0.01472355, 0.01470858, 0.01469364, 0.01467874, 0.01466387, 0.01464902, 0.01463421, 0.01461943, 0.01460468, 0.01458994, 0.01457525, 0.0145606, 0.01454595, 0.01453134, 0.01451677, 0.01450222, 0.01448771, 0.01447321, 0.01445876, 0.01444434, 0.01442994, 0.01441555, 0.0144012, 0.01438688, 0.0143726, 0.01435834, 0.01434411, 0.0143299, 0.01431574, 0.01430158, 0.01428746, 0.01427337, 0.01425932, 0.00712267, 0.00711572, 0.00710877, 0.00710183, 0.00709492, 0.00708801, 0.00708111, 0.00707422, 0.00706735, 0.0070605, 0.00705365, 0.00704682, 0.00704002, 0.00703322, 0.00702643, 0.00701965, 0.00701289, 0.00700614, 0.00699941, 0.00699268, 0.00698598, 0.00697928, 0.00697259, 0.00696591, 0.00695927, 0.00695261, 0.00694598, 0.00693936, 0.00693275, 0.00692615, 0.00691958, 0.00691299, 0.00690644, 0.0068999, 0.00689336, 0.00688683, 0.00688034, 0.00687383, 0.00686735, 0.00686087, 0.00685441, 0.00684797, 0.00684153, 0.0068351, 0.0068287, 0.00682229, 0.00681591, 0.00680954, 0.00340159, 0.00339842, 0.00339526, 0.00339211, 0.00338897, 0.00338581, 0.00338268, 0.00337956, 0.00337643, 0.0033733, 0.00337019, 0.00336709, 0.00336398, 0.00336088, 0.00335778, 0.00335471, 0.00335163, 0.00334856, 0.00334549, 0.00334243, 0.00333936, 0.00333632, 0.00333327, 0.00333022, 0.00332719, 0.00332416, 0.00332115, 0.00331813, 0.0033151, 0.0033121, 0.00330909, 0.00330611, 0.00330311, 0.00330012, 0.00329715, 0.00329416, 0.0032912, 0.00328823, 0.00328528, 0.00328233, 0.00327937, 0.00327644, 0.0032735, 0.00327056, 0.00326764, 0.00326471, 0.00326179, 0.00325888, 0.00162799, 0.00162653, 0.0016251, 0.00162365, 0.00162221, 0.00162076, 0.00161934, 0.00161791, 0.00161648, 0.00161504, 0.00161361, 0.00161219, 0.00161078, 0.00160936, 0.00160795, 0.00160654, 0.00160512, 0.00160371, 0.00160232, 0.00160091, 0.0015995, 0.0015981, 0.00159671, 0.00159532, 0.00159393, 0.00159253, 0.00159115, 0.00158977, 0.00158838, 0.001587, 0.00158564, 0.00158426, 0.00158289, 0.00158152, 0.00158016, 0.00157878, 0.00157742, 0.00157606, 0.0015747, 0.00157336, 0.001572, 0.00157065, 0.0015693, 0.00156796, 0.00156661, 0.00156526, 0.00156394, 0.00156259, 0.00078062, 0.00077996, 0.0007793, 0.00077864, 0.00077796, 0.00077731, 0.00077664, 0.000776, 0.00077532, 0.00077468, 0.00077402, 0.00077338, 0.00077272, 0.00077207, 0.00077141, 0.00077075, 0.00077012, 0.00076947, 0.00076882, 0.00076817, 0.00076752, 0.00076688, 0.00076625, 0.0007656].map(&:to_s)

        valid_get api_v1_monetary_datum_url("inflation_rate")
        assert_equal expected_nominal_apc, json.dig("data", "attributes", "inflation_rate", "nominal_apc")
        assert_equal expected_nominal_inflation_rate, json.dig("data", "attributes", "inflation_rate", "nominal_inflation_rate")
        assert_equal expected_real_inflation_rate, json.dig("data", "attributes", "inflation_rate", "real_inflation_rate")
      end

      test "should respond with error object when indicator name is invalid" do
        error_object = Api::V1::Exceptions::IndicatorNameInvalidError.new
        response_json = RequestErrorSerializer.new([error_object], message: error_object.title).serialized_json

        valid_get api_v1_monetary_datum_url("dao")

        assert_equal response_json, response.body
      end
    end
  end
end
