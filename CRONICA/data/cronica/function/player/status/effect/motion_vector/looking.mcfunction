# =================================================================================================

##【 IMPULSE 】

  ## 指定の力で視点方向に対象を飛ばす

    # プレイヤー管理

      # オーナータグ付け
        tag @s add TAG.cronica.STATUS.MotionVector.Owner

      # 現在のモーションをリセット
        tp @s 0 0 0
        tp @s ~ ~ ~


# やっぱこっちだったよ


    # データ管理

      # ストレージを初期化
        data remove storage cronica:temp MotionVector
        data modify storage cronica:temp MotionVector set value { \
          Signs: {X: 1, Y: 1, Z: 1}, \
          Macro: {X1: 0, X2: 0, X3: 0, Y1: 0, Y2: 0, Y3: 0, Z1: 0, Z2: 0, Z3: 0, SignY: "+"} \
        }

      # 指定された力の強さを取得
        scoreboard objectives add SCORE.cronica.STATUS.MotionVector dummy
        $scoreboard players set #VectorMaster SCORE.cronica.STATUS.MotionVector $(VectorPower)
        execute if score #VectorMaster SCORE.cronica.STATUS.MotionVector matches 1000001.. run scoreboard players set #VectorMaster SCORE.cronica.STATUS.MotionVector 1000000
        execute if score #VectorMaster SCORE.cronica.STATUS.MotionVector matches ..-1000001 run scoreboard players set #VectorMaster SCORE.cronica.STATUS.MotionVector -1000000
        scoreboard players add #VectorMaster SCORE.cronica.STATUS.MotionVector 0

      # 向いている方向から分解ベクトルを取得
        execute positioned 0.0 0.0 0.0 summon marker run function cronica:player/status/effect/motion_vector/library/get_rotation

      # ベクトルごとの強さ計算
        function cronica:player/status/effect/motion_vector/library/calculation {Vector: "X"}
        function cronica:player/status/effect/motion_vector/library/calculation {Vector: "Y"}
        function cronica:player/status/effect/motion_vector/library/calculation {Vector: "Z"}
        execute if data storage cronica:temp MotionVector.Signs{Y:-1} run data modify storage cronica:temp MotionVector.Macro.SignY set value "-"

      # スコア撤去
        scoreboard objectives remove SCORE.cronica.STATUS.MotionVector

    # モーション付与
      function cronica:player/status/effect/motion_vector/library/explode with storage cronica:temp MotionVector.Macro
# =================================================================================================
# ver 0.14.0
