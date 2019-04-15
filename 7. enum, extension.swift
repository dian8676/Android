import Foundation

 

class Robot{

    var name:String

    var x:Int

    var y:Int

    var distance:Int

    

    init(_ name:String) {

        self.name = name

        self.x = 100

        self.y = 100

        self.distance = 5

    }

    

    func move(_ direction:Int){

        var tmpx = self.x

        var tmpy = self.y

        switch direction {

        case 1: //��

            tmpx = tmpx - self.distance

        case 2: //��

            tmpx = tmpx + self.distance

        case 3: //left

            tmpy = tmpy - self.distance

        case 4: //right

            tmpy = tmpy + self.distance

        case 5: //upleft

            tmpx = tmpx - self.distance

            tmpy = tmpy - self.distance

        case 6: //upright

            tmpx = tmpx - self.distance

            tmpy = tmpy + self.distance

        case 7: //downleft

            tmpx = tmpx + self.distance

            tmpy = tmpy - self.distance

        case 8: //downright

            tmpx = tmpx + self.distance

            tmpy = tmpy + self.distance

        default:

            print("����")

        }

        

        if(tmpx >= 0) && (tmpx <= 200){

            self.x = tmpx

        }else if tmpx < 0 {

            self.x = 0

        }else{

            self.x = 200

        }

        if(tmpy >= 0) && (tmpy <= 200){

            self.y = tmpy

        }else if tmpy < 0{

            self.y = 0

        }else{

            self.y = 200

        }

    }

    

    func toStirng(){

        print(name, distance, x, y, separator:"\\t", terminator:"\\t")

    }

    

    subscript (_ name:String) -> Bool {

        if (name == self.name){

            return true

        }

        return false

    }

    subscript (_ x1:Int,_ y1:Int,_ x2:Int,_ y2:Int) -> Bool{

        if(x1 <= x2){

            if (y1 <= y2){

                if(self.x >= x1) && (self.x <= x2) && (self.y >= y1) && (self.y <= y2){

                    return true

                }

            }else{

                if(self.x >= x1) && (self.x <= x2) && (self.y <= y1) && (self.y >= y2){

                    return true

                }

            }

        }else{

            if (y1 <= y2){

                if(self.x <= x1) && (self.x >= x2) && (self.y >= y1) && (self.y <= y2){

                    return true

                }

            }else{

                if(self.x <= x1) && (self.x >= x2) && (self.y <= y1) && (self.y >= y2){

                    return true

                }

            }

        }

        return false

    }

}

 

class CleaningRobot:Robot{

    var cleaningPower:Int

    

    init(_ name: String,_ power:Int) {

        self.cleaningPower = power

        super.init(name)

        self.x = 30

        self.y = 30

        self.distance = 3

    }

    func cleaningPowerUp(_ power:Int){

        let tmp = self.cleaningPower+power

        if tmp > 10{

            print("�ִ��Ŀ��� 10�Դϴ�. �ִ�� �����մϴ�.")

            self.cleaningPower = 10

        }else{

            self.cleaningPower = tmp

        }

    }

    func cleaningPowerDown(_ power:Int){

        let tmp = self.cleaningPower-power

        if tmp < 0{

            print("�ּ��Ŀ��� 0�Դϴ�. �ּҷ� �����մϴ�.")

            self.cleaningPower = 0

        }else{

            self.cleaningPower = tmp

        }

    }

    override func toStirng() {

        super.toStirng()

        print("Cleaning Power = ",self.cleaningPower,terminator:"")

    }

}

class DogRobot:Robot{

    var barkPower:Int

    

    init(_ name: String,_ power:Int) {

        self.barkPower = power

        super.init(name)

        self.x = 150

        self.y = 150

        self.distance = 10

    }

    func barkUp(_ power:Int){

        let tmp = self.barkPower + power

        if tmp > 10{

            print("�ִ��Ŀ��� 10�Դϴ�. �ִ�� �����մϴ�.")

            self.barkPower = 10

        }else{

            self.barkPower = tmp

        }

    }

    func barkDown(_ power:Int){

        let tmp = self.barkPower - power

        if tmp < 0{

            print("�ּ��Ŀ��� 0�Դϴ�. �ּҷ� �����մϴ�.")

            self.barkPower = 0

        }else{

            self.barkPower = tmp

        }

    }

    override func toStirng() {

        super.toStirng()

        print("Bark Power = ",self.barkPower,terminator:"")

    }

}

 

enum RobotError : Error{

    case isNull

    case isNumber

}

 

func checkNull(_ input:String) throws{

    guard !(input.isEmpty) else {throw RobotError.isNull}

}

func checkNumber(_ input:String) throws ->Int{

    guard let number = Int(input) else {throw RobotError.isNumber}

    return number

}

func checkDirect(_ input:String) throws{

    //guard//

}

 

var robotList:[Robot] = []

 

robotList.append(Robot("aa"))

robotList.append(CleaningRobot("cc",10))

robotList.append(CleaningRobot("dd",10))

robotList.append(DogRobot("bb",3))

 

func printRobotList(){

    print("id\\t�̸�\\t�Ÿ�\\tx\\ty\\tetc")

    print("---------------------------------")

    for i in 0..<robotList.count{

        print(i+1,terminator:"\\t")

        robotList[i].toStirng()

        print("")

    }

    

}

 

func checkMove(_ id:Int,_ robot:Robot,_ direction:Int) -> Bool{

    let tmpRobot:Robot

    if robot is CleaningRobot {

        tmpRobot = CleaningRobot("",0)

    }else if robot is DogRobot {

        tmpRobot = DogRobot("",0)

    }else{

        tmpRobot = Robot("")

    }

    tmpRobot.x = robot.x

    tmpRobot.y = robot.y

    tmpRobot.move(direction)

    for i in 0..<robotList.count{

        if(robotList[i].x == tmpRobot.x) && (robotList[i].y == tmpRobot.y) && (id-1 != i){

            print("�κ� ",id,"���� (\\(robot.x),\\(robot.y))���� (\\(tmpRobot.x),\\(tmpRobot.y))���� �̵��Ϸ��� ������, \\(i+1)��",terminator:" ")

            if robotList[i] is CleaningRobot{

                print("Cleaning",terminator:" ")

            }else if robotList[i] is DogRobot{

                print("Dog",terminator:" ")

            }

            print("�κ��� �־� �̵����� ���߽��ϴ�.")

            return false

        }

    }

    return true

}

 

enum Direct:Int{

    case up = 1

    case down = 2

    case left = 3

    case right = 4

    case upleft = 5

    case upright = 6

    case downleft = 7

    case downright = 8

    case other

}

 

while(true){

    print("===============")

    print("1. �κ������Ͱ���")

    print("2. �κ�����Ʈ����")

    print("3. �����κ��̵�")

    print("4. �κ��˻�")

    print("===============")

    print("�Է� : ",terminator:"")

    let numberInput = readLine()!

    do{

        try checkNull(numberInput)

        let number = try checkNumber(numberInput)

        

        switch number{

        case 1:

            print("�κ������Ͱ���")

            print("1. �κ� ������ �߰�")

            print("2. �κ� ������ �̸� ����")

            print("3. �κ� ������ ����")

            print("�Է� : ",terminator:"")

            let oneInput = readLine()!

            try checkNull(oneInput)

            let one = try checkNumber(oneInput)

            switch one{

            case 1 :

                print("�κ� �̸� �Է� : ",terminator:"")

                let name = readLine()!

                try checkNull(name)

                print("r:Robot, c:CleaningRobot, d:DogRobot")

                print("�κ� ���� �Է� : ",terminator:"")

                let type = readLine()!

                try checkNull(type)

                switch type{

                case "r":

                    robotList.append(Robot(name))

                case "c":

                    print("power : ",terminator:"")

                    let powerInput = readLine()!

                    try checkNull(powerInput)

                    let power = try checkNumber(powerInput)

                    robotList.append(CleaningRobot(name,power))

                case "d":

                    print("power : ",terminator:"")

                    let powerInput = readLine()!

                    try checkNull(powerInput)

                    let power = try checkNumber(powerInput)

                    robotList.append(DogRobot(name,power))

                default:

                    print("�ش��ϴ� ������ �����ϴ�.")

                }

                

            case 2:

                print("�κ� �̸� ����")

                printRobotList()

                print("������ �κ� ��ȣ �Է� : ",terminator:"")

                let modIdInput = readLine()!

                try checkNull(modIdInput)

                let modId = try checkNumber(modIdInput)

                if (modId >= 1) && (modId <= robotList.count){

                    print("������ �̸� �Է� : ",terminator:"")

                    let modName = readLine()!

                    do{

                        try checkNull(modName)

                        robotList[modId-1].name = modName

                        print(modName,"���� �����Ͽ����ϴ�.")

                    }catch RobotError.isNull{

                        print("[null]�Էµ� ���� �����ϴ�.")

                    }

                }else{

                    print("�ش� �κ��� �������� �ʽ��ϴ�.")

                }

                

            case 3:

                print("�κ� ������ ����")

                printRobotList()

                print("������ �κ� ��ȣ �Է� : ",terminator:"")

                let delIdInput = readLine()!

                try checkNull(delIdInput)

                let delId = try checkNumber(delIdInput)

                if (delId >= 1) && (delId <= robotList.count){

                    robotList.remove(at: delId - 1)

                    print("�����Ͽ����ϴ�.")

                }else{

                    print("�ش� �κ��� �������� �ʽ��ϴ�.")

                }

                

            default:

                print("�ش� ���ڰ� �ƴմϴ�.")

            }

        case 2:

            print("�κ� ����Ʈ ����")

            print("1.�κ� �̸� �� ����")

            print("2.�κ� �̸� ���� ����")

            print("3.�κ� ��ġ x->y�� ����")

            print("�Է� : ",terminator:"")

            let two = readLine()!

            try checkNull(two)

            let twoNum = try checkNumber(two)

            switch twoNum{

            case 1:

                print("�̸�������")

                print("�̸�\\t�Ÿ�\\tx\\ty\\tetc")

                print("---------------------------------")

                for i in robotList.sorted(by: {\$0.name < \$1.name}){

                    i.toStirng()

                    print("")

                }

            case 2:

                print("�̸���������")

                print("�̸�\\t�Ÿ�\\tx\\ty\\tetc")

                print("---------------------------------")

                for i in robotList.sorted(by: {\$0.name > \$1.name}){

                    i.toStirng()

                    print("")

                }

            case 3:

                print("�κ� ��ġ")

                print("�̸�\\t�Ÿ�\\tx\\ty\\tetc")

                print("---------------------------------")

                for i in robotList.sorted(by: {(s1:Robot,s2:Robot)->Bool in

                    if s1.x==s2.x { return s1.y<s2.y }

                    return s1.x<s2.x}){

                        i.toStirng()

                        print("")

                }

            default:

                print("�ش� ���ڰ� �ƴմϴ�.")

            }

        case 3:

            printRobotList()

            print("�̵��� �κ� ��ȣ �Է� : ",terminator:"")

            let move = readLine()!

            try checkNull(move)

            let moveId = try checkNumber(move)

            if(moveId > 0) && (moveId <= robotList.count){

                print("�̵����� (up,down,left,right,upleft,upright,downleft,downright) : ",terminator:"")

                let direction = readLine()!

                try checkNull(direction)

                let moveRobot = robotList[moveId - 1]

                var dr:Direct = .other

                

                switch direction {

                case "up" :

                    dr = .up

                case "down":

                    dr = .down

                case "left":

                    dr = .left

                case "right":

                    dr = .right

                case "upleft" :

                    dr = .upleft

                case "upright":

                    dr = .upright

                case "downleft":

                    dr = .downleft

                case "downright":

                    dr = .downright

                default:

                    dr = .other

                    print("�ش� ������ �������� �ʽ��ϴ�.")

                }

                

                if (dr != .other) && (checkMove(moveId, moveRobot, dr.rawValue)){

                    print("�κ� ",moveId,"���� (\\(moveRobot.x),\\(moveRobot.y))���� ",terminator:"")

                    moveRobot.move(dr.rawValue)

                    print("(\\(moveRobot.x),\\(moveRobot.y))���� �̵��Ͽ����ϴ�.")

                }

            }else{

                print("�ش� �κ��� �������� �ʽ��ϴ�.")

            }

        case 4:

            print("�κ� �˻�")

            print("1. �κ� ������ �˻�")

            print("2. (x1,y1,x2,y2)�Է��ؼ� ���Ե� �κ� �˻�")

            print("�Է� : ",terminator:"")

            let four = readLine()!

            try checkNull(four)

            let fourNum = try checkNumber(four)

            switch fourNum{

            case 1:

                print("�˻��� �̸� �Է� : ",terminator:"")

                let searchName = readLine()!

                try checkNull(searchName)

                

                let searchArr = robotList.filter({\$0[searchName]})

                print("�̸�\\t�Ÿ�\\tx\\ty\\tetc")

                print("---------------------------")

                for i in searchArr{

                    i.toStirng()

                    print("")

                }

            case 2:

                print("x1,y1,x2,y2 �Է� (����� ����) : ",terminator:"")

                let inputNum = readLine()!

                try checkNull(inputNum)

                let numbers = try inputNum.split(separator: " ").map({try checkNumber(String(\$0))})

                if numbers.count == 4{

                    let x1 = numbers[0]

                    let y1 = numbers[1]

                    let x2 = numbers[2]

                    let y2 = numbers[3]

                    

                    var count = 0

                    print("�̸�\\t�Ÿ�\\tx\\ty\\tetc")

                    print("---------------------------------")

                    for i in robotList{

                        if i[x1,y1,x2,y2]{

                            i.toStirng()

                            print("")

                        }else{

                            count = count+1

                        }

                    }

                    if count == robotList.count{

                        print("�����ȿ� �κ��� �����ϴ�.")

                    }

                }

            default:

                print("�ش� ���ڰ� �ƴմϴ�.")

            }

        default:

            print("�ش� ���ڰ� �ƴմϴ�.")

        }

        

    }catch RobotError.isNull{

        print("[null]�Էµ� ���� �����ϴ�.")

    }catch RobotError.isNumber{

        print("[number]�Էµ� ���� ���ڰ� �ƴմϴ�.")

    }

    

}

 